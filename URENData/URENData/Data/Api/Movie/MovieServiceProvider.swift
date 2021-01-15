//
//  MovieServiceProvider.swift
//  URENData
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENDomain

public protocol MovieServiceProvider {
    func getMovies(request: MovieRequest) -> UrlRequestConvertible
    func getMovieDetail(request: MovieDetailRequest) -> UrlRequestConvertible
}
