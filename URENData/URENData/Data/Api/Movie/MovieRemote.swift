//
//  MovieRemote.swift
//  URENData
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCombine
import URENDomain

public class MovieRemote: MovieRemoteProvider {
    
    private let httpClient: HttpClientProvider
    private let service: MovieServiceProvider
    
    public init(httpClient: HttpClientProvider, service: MovieServiceProvider) {
        self.httpClient = httpClient
        self.service = service
    }
    
    public func getMovies(request: MovieRequest) -> Future<MovieResponse, Error> {
        return httpClient.execute(convertible: service.getMovies(request: request))
    }
    
    public func getMovieDetail(request: MovieDetailRequest) -> Future<MovieDetailResponse, Error> {
        return httpClient.execute(convertible: service.getMovieDetail(request: request))
    }
}
