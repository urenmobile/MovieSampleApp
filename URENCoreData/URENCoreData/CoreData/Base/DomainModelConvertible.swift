//
//  DomainModelConvertible.swift
//  URENCoreData
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation

public protocol DomainModelConvertible {
    associatedtype ModelType
    
    func toDomain() -> ModelType
}
