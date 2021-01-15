//
//  Constants.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/14/21.
//

import Foundation

enum Constants {
    static var language: String {
        return "\(languageCode)-\(regionCode)"
    }
    
    static var languageCode = Locale.current.languageCode ?? "en"
    static var regionCode = Locale.current.regionCode ?? "US"
    
    static func getImageUrl(width: Int, path: String) -> String {
        return "https://image.tmdb.org/t/p/w\(width)\(path)"
    }

}
