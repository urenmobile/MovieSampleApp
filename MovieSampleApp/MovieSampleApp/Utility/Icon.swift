//
//  Icon.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/11/21.
//

import Foundation

enum Icon: String {
    case grid = "iconGrid"
    case list = "iconList"
    case star = "iconStar"
    case starFilled = "iconStarFilled"
    
    var name: String {
        return rawValue
    }
}
