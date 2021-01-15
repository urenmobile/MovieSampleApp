//
//  MovieLocalRepositoryProvider.swift
//  URENCoreData
//
//  Created by Remzi YILDIRIM on 1/13/21.
//

import Foundation
import URENDomain

public protocol MovieLocalRepositoryProvider {
    
    func create(_ model: MovieModel)
    func update(_ model: MovieModel)
    func delete(_ model: MovieModel)
    func get(by predicate: NSPredicate?) -> Result<[MovieModel], Error>
    func isExists(predicate: NSPredicate) -> Bool
    @discardableResult
    func save() -> Result<Bool, Error>
}
