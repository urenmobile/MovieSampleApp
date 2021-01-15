//
//  MovieAddFavoriteRequest.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/13/21.
//

import Foundation

public struct MovieAddFavoriteRequest: Model {
    public let movie: MovieModel
    
    public init(movie: MovieModel) {
        self.movie = movie
    }
}
