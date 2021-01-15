//
//  MovieDetailRequest.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation

public struct MovieDetailRequest: Model {
    public let id: Int
    public let language: String
    
    public init(id: Int,
                language: String) {
        self.id = id
        self.language = language
    }
    
    enum CodingKeys: String, CodingKey  {
        case id
        case language
    }
}
