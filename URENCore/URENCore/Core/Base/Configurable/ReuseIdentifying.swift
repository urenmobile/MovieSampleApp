//
//  ReuseIdentifying.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    public static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
