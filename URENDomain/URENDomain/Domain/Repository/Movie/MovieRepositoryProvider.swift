//
//  MovieRepositoryProvider.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCombine

public protocol MovieRepositoryProvider {
    func getMovies(request: MovieRequest) -> Future<MovieResponse, Error>
    func getMovieDetail(request: MovieDetailRequest) -> Future<MovieDetailResponse, Error>
    func addFavorite(request: MovieAddFavoriteRequest) -> Future<MovieAddFavoriteResponse, Error>
    func removeFavorite(request: MovieRemoveFavoriteRequest) -> Future<MovieRemoveFavoriteResponse, Error>
}
