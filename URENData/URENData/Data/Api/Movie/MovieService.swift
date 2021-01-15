//
//  MovieService.swift
//  URENData
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENDomain

public class MovieService: MovieServiceProvider {
    
    public init() { }
    
    public func getMovies(request: MovieRequest) -> UrlRequestConvertible {
        return MovieServiceModel(request: request)
    }
    
    public func getMovieDetail(request: MovieDetailRequest) -> UrlRequestConvertible {
        return MovieDetailServiceModel(request: request)
    }
}

extension MovieService {
    // MARK: MovieServiceModel
    public class MovieServiceModel: BaseRequestConvertible<MovieRequest> {
        
        public init(request: MovieRequest) {
            super.init(environment: EnvironmentManager.shared.environment, method: .get, path: Endpoints.Paths.movies, data: request)
        }
    }

    // MARK: ProductDetailServiceModel
    public class MovieDetailServiceModel: BaseRequestConvertible<MovieDetailRequest> {
        
        public init(request: MovieDetailRequest) {
            super.init(environment: EnvironmentManager.shared.environment, method: .get, path: Endpoints.Paths.movieDetail(id: request.id), data: request)
        }
    }
}
