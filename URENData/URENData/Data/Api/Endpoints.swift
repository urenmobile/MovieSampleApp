//
//  Endpoints.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public enum Endpoints {
    
}

extension Endpoints {
    public enum Paths {
        case products
        case productDetail(productId: String)
        case movies
        case movieDetail(id: Int)
        
        public var path: String {
            switch self {
            case .products:
                return "cart/list"
            case .productDetail(let productId):
                return "cart/\(productId)/detail"
            case .movies:
                return "popular"
            case .movieDetail(let id):
                return "\(id)"
            }
        }
    }
}
