//
//  BaseCoreDataRepository.swift
//  URENCoreData
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation
import URENCore
import CoreData

public class BaseCoreDataRepository<EntityType>: CoreDataRepositoryProvider where EntityType: NSManagedObject {
    
    public typealias Entity = EntityType
    
    private let context: NSManagedObjectContext
    
    public init(persistentContainer: NSPersistentContainer) {
        context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    public func create() -> Entity {
        return Entity(context: context)
    }
    
    public func delete(_ entity: Entity) {
        context.delete(entity)
    }
    
    public func fetch(by predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        return fetch(fetchRequest)
    }
    
    public func saveContext() -> Result<Bool, Error> {
        // FIXME: Before call this function, may need call context.perform { }
        
        guard context.hasChanges else {
            return .success(false)
        }
            
        // FIXME: save in context.performAndWait { } to ensures
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
extension BaseCoreDataRepository {
    public enum CoreDataError: Error {
        case fetchError
        case commitError
    }
}
