//
//  Environment.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public enum Environment {
    case development
    case test
    case prod
    case release
    
    public var name: String {
        switch self {
        case .development:
            return "DEV"
        case .test:
            return "TEST"
        case .prod:
            return "PROD"
        case .release:
            return ""
        }
    }
    
    public var host: String {
        // Should be separated by the environment
        switch self {
        case .development, .test:
            return "https://api.themoviedb.org/3/movie"
        case .prod, .release:
            return "https://api.themoviedb.org/3/movie"
        }
    }
    
    public var additionalParams: [String: String] {
        return ["api_key": "fd2b04342048fa2d5f728561866ad52a"]
    }
}
