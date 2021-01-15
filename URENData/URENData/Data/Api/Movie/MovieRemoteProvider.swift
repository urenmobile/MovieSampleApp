//
//  MovieRemoteProvider.swift
//  URENData
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENDomain
import URENCombine

public protocol MovieRemoteProvider {
    func getMovies(request: MovieRequest) -> Future<MovieResponse, Error>
    func getMovieDetail(request: MovieDetailRequest) -> Future<MovieDetailResponse, Error>
}
