//
//  ImageCacheProvider.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit

public protocol ImageCacheProvider {
    func image(forKey: String) -> UIImage?
    func cacheImage(_ image: UIImage, forKey: String)
    func clearCache()
}
