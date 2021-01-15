//
//  BaseLocalRepository.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation
import CoreData
import URENCore

open class BaseLocalRepository<EntityType>: LocalRepositoryProvider where EntityType: NSManagedObject {

    public typealias Entity = EntityType
    
    private let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    open func create() -> Entity {
        return Entity(context: context)
    }
    
    open func read() -> Entity? {
        FatalHelper.notImplementedError()
    }
    
    open func delete(_ entity: Entity) {
        context.delete(entity)
    }
    
    open func fetch(by predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[EntityType], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        return fetch(fetchRequest)
    }
    
    open func saveContext() -> Result<Bool, Error> {
        context.performAndWait {
            
        }
        
        guard context.hasChanges else {
            return .success(true)
        }
        
        do {
            try self.context.save()
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            return .failure(CoreDataError.commitError)
        }
        return .success(true)
    }
    
    private func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) -> Result<[EntityType], Error> {
        do {
            guard let fetchedObjects = try context.fetch(request) as? [Entity] else {
                return .failure(CoreDataError.fetchError)
            }
            return .success(fetchedObjects)
        } catch {
            debugPrint("Fetch for type: \(Entity.self) - error: \(error)")
            return .failure(error)
        }
    }
    
    private func save(context: NSManagedObjectContext) -> Result<Bool, Error> {
        guard context.hasChanges else {
            return .success(true)
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            return .failure(CoreDataError.commitError)
        }
        return .success(true)
    }
}

// MARK: - CoreDataError
extension BaseLocalRepository {
    public enum CoreDataError: Error {
        case fetchError
        case commitError
    }
}
