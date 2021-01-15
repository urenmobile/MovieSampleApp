//
//  MovieRequest.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation

public struct MovieRequest: Model {
    let page: Int
    let language: String
    
    public init(page: Int,
                language: String) {
        self.page = page
        self.language = language
    }
    
    enum CodingKeys: String, CodingKey  {
        case page
        case language
    }
}
