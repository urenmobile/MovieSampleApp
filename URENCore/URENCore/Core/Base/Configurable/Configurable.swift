//
//  Configurable.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol Configurable: ReuseIdentifying {
    associatedtype ViewModelType
    
    func configure(with viewModel: ViewModelType)
    
}
