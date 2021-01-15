//
//  MovieModel.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation

public class MovieModel: Model {
    public let id: Int?
    public let title: String?
    public let overview: String?
    public let voteCount: Int?
    public let popularity: Float?
    public let posterPath: String?
    public let backdropPath: String?
    public var isFavorite: Bool?
    
    public init(id: Int?,
                title: String?,
                overview: String?,
                voteCount: Int?,
                popularity: Float?,
                posterPath: String?,
                backdropPath: String?,
                isFavorite: Bool?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteCount = voteCount
        self.popularity = popularity
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.isFavorite = isFavorite
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteCount = "vote_count"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case isFavorite
    }
}
