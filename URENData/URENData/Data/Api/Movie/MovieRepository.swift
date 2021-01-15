//
//  MovieRepository.swift
//  URENData
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCombine
import URENDomain
import URENCoreData

public class MovieRepository: MovieRepositoryProvider {
    
    private let remote: MovieRemoteProvider
    private let local: MovieLocalRepositoryProvider
    
    public init(remote: MovieRemoteProvider, local: MovieLocalRepositoryProvider) {
        self.remote = remote
        self.local = local
    }
    
    public func getMovies(request: MovieRequest) -> Future<MovieResponse, Error> {
        
        return Future { [weak self] (promise) in
            self?.remote.getMovies(request: request).sink { [weak self] in
                if case let .success(response) = $0 {
                    response.results?.forEach { self?.local.create($0) }
                    self?.local.save()
                }
                promise($0)
            }
        }
    }
    
    public func getMovieDetail(request: MovieDetailRequest) -> Future<MovieDetailResponse, Error> {
        
        return Future { [weak self] (promise) in
            self?.remote.getMovieDetail(request: request).sink { [weak self] in
                if case let .success(response) = $0 {
                    let id = response.id ?? 0
                    let predicate = NSPredicate(format: "id == %d", id)
                    let result = self?.local.get(by: predicate)
                    if case let .success(movies) = result {
                        response.isFavorite = movies.first?.isFavorite ?? false
                    }
                    self?.local.save()
                }
                promise($0)
            }
        }
    }
    
    public func addFavorite(request: MovieAddFavoriteRequest) -> Future<MovieAddFavoriteResponse, Error> {
        return Future { [weak self] (promise) in
            self?.local.update(request.movie)
            self?.local.save()
            
            let response = MovieAddFavoriteResponse(movie: request.movie)
            promise(.success(response))
        }
    }
    
    public func removeFavorite(request: MovieRemoveFavoriteRequest) -> Future<MovieRemoveFavoriteResponse, Error> {
        
        return Future { [weak self] (promise) in
            self?.local.update(request.movie)
            self?.local.save()
            
            let response = MovieRemoveFavoriteResponse(movie: request.movie)
            promise(.success(response))
        }
    }
}
