//
//  ProductDetailViewData.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit

class ProductDetailViewData {
    let title: String?
    let description: String?
    let detail: String?
    let imageUrl: String?
    let isFavorite: Bool
    let showFavorite: Bool
    
    init(title: String?,
         description: String?,
         detail: String?,
         imageUrl: String?,
         isFavorite: Bool = false,
         showFavorite: Bool = false) {
        self.title = title
        self.detail = detail
        self.description = description
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
        self.showFavorite = showFavorite
    }
}
