//
//  MovieLocalRepository.swift
//  URENCoreData
//
//  Created by Remzi YILDIRIM on 1/13/21.
//

import Foundation
import URENDomain

public class MovieLocalRepository: MovieLocalRepositoryProvider {
    
    private let repository: MovieCoreDataRepository
    
    public init(repository: MovieCoreDataRepository) {
        self.repository = repository
    }
    
    public func create(_ model: MovieModel) {
        let id = Int32(model.id ?? 0)
        
        let predicate = NSPredicate(format: "id == %d", id)
        let isFavorite = isFavoriteMovie(predicate: predicate)
        
        let entity = repository.create()
        entity.id = id
        entity.title = model.title
        entity.overview = model.overview
        entity.voteCount = Int16(model.voteCount ?? 0)
        entity.popularity = model.popularity ?? 0
        entity.posterPath = model.posterPath
        entity.backdropPath = model.backdropPath
        entity.isFavorite = isFavorite
    }
    
    public func update(_ model: MovieModel) {
        guard let id = model.id else {
            return
        }
        let predicate = NSPredicate(format: "id == %d", id)
        let result = repository.fetch(by: predicate, sortDescriptors: nil)
        switch result {
        case .success(let entities):
            entities.first?.isFavorite = model.isFavorite ?? false
        case .failure(let error):
            debugPrint("update error: \(error)")
        }
    }
    
    public func delete(_ model: MovieModel) {
        guard let movieId = model.id else {
            return
        }
        
        let predicate = NSPredicate(format: "id == %d", movieId)
        
        let result = repository.fetch(by: predicate, sortDescriptors: nil)
        switch result {
        case .success(let entities):
            guard let entity = entities.first else {
                return
            }
            repository.delete(entity)
        case .failure(let error):
            debugPrint("Delete error: \(error)")
        }
    }
    
    public func get(by predicate: NSPredicate?) -> Result<[MovieModel], Error> {
        let popularitySort = NSSortDescriptor(key: #keyPath(MovieEntity.popularity), ascending: false)
        let result = repository.fetch(by: predicate, sortDescriptors: [popularitySort])
        
        switch result {
        case .success(let entites):
            let movies = entites.map { $0.toDomain() }
            return .success(movies)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func isExists(predicate: NSPredicate) -> Bool {
        let result = repository.fetch(by: predicate, sortDescriptors: nil)
        switch result {
        case .success(let entities):
            return !entities.isEmpty
        case .failure(let error):
            debugPrint("Delete error: \(error)")
        }
        return false
    }
    
    public func save() -> Result<Bool, Error> {
        return repository.saveContext()
    }
    
    private func isFavoriteMovie(predicate: NSPredicate) -> Bool {
        let result = repository.fetch(by: predicate, sortDescriptors: nil)
        switch result {
        case .success(let entities):
            return entities.first?.isFavorite ?? false
        case .failure(let error):
            debugPrint("isFavorite error: \(error)")
        }
        return false
    }
}

extension MovieEntity: DomainModelConvertible {
    public func toDomain() -> MovieModel {
        return MovieModel(id: Int(id),
                          title: title,
                          overview: overview,
                          voteCount: Int(voteCount),
                          popularity: popularity,
                          posterPath: posterPath,
                          backdropPath: backdropPath,
                          isFavorite: isFavorite)
    }
}
