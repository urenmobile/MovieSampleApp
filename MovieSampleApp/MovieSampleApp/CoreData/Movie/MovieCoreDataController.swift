//
//  MovieCoreDataController.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/14/21.
//

import Foundation
import CoreData
import URENDomain
import URENCombine
import URENCoreData

public class MovieCoreDataController: NSObject {
    
    public var reloadableChangesSubject = PassthroughSubject<ReloadableChanges, Never>()
    
    private var insertItems: [IndexPath] = []
    private var deleteItems: [IndexPath] = []
    private var reloadItems: [IndexPath] = []
    private var moveItems: [(from: IndexPath, to: IndexPath)] = []

    private var defaultFetchedResultsController: NSFetchedResultsController<MovieEntity>!
    
    private var fetchedResultsController: NSFetchedResultsController<MovieEntity> = {
        let createDateSort = NSSortDescriptor(key: #keyPath(MovieEntity.popularity), ascending: false)
        let request: NSFetchRequest = MovieEntity.fetchRequest()
        request.sortDescriptors = [createDateSort]
        request.fetchBatchSize = 20
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    public override init() {
        defaultFetchedResultsController = fetchedResultsController
        super.init()
        fetchedResultsController.delegate = self
    }
    
    private func changeBackToDefaultController() {
        fetchedResultsController = defaultFetchedResultsController
        fetchedResultsController.delegate = self
    }
    
    private func createFilterController(with text: String) {
        let titleSort = NSSortDescriptor(key: #keyPath(MovieEntity.popularity), ascending: true)
        let request: NSFetchRequest = MovieEntity.fetchRequest()
        request.sortDescriptors = [titleSort]
        request.predicate = NSPredicate(format: "title contains[cd] %@", text)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController = fetchedResultsController
        self.fetchedResultsController.delegate = self
        defaultFetchedResultsController.delegate = nil
    }
    
    private func insertItem(to indexPath: IndexPath) {
        insertItems.append(indexPath)
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        deleteItems.append(indexPath)
    }
    
    private func reloadItem(at indexPath: IndexPath) {
        reloadItems.append(indexPath)
    }
    
    private func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveItems.append((from: indexPath, newIndexPath))
    }
    
    private func performBatchUpdate() {
        let reloadableChanges = ReloadableChanges(insertItems: insertItems,
                                                  deleteItems: deleteItems,
                                                  reloadItems: reloadItems,
                                                  moveItems: moveItems)

        reloadableChangesSubject.send(reloadableChanges)
        insertItems.removeAll()
        deleteItems.removeAll()
        reloadItems.removeAll()
        moveItems.removeAll()
    }
}

extension MovieCoreDataController: NSFetchedResultsControllerDelegate {
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return
            }
            debugPrint("**** insert indexPath: \(newIndexPath)")
            insertItem(to: newIndexPath)
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            debugPrint("**** delete indexPath: \(indexPath)")
            deleteItem(at: indexPath)
        case .update:
            guard let indexPath = indexPath else {
                return
            }
            debugPrint("**** update indexPath: \(indexPath)")
            reloadItem(at: indexPath)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {
                return
            }
            debugPrint("**** move from indexPath: \(indexPath) to \(newIndexPath)")
            moveItem(at: indexPath, to: newIndexPath)
        @unknown default:
            debugPrint("Error")
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        performBatchUpdate()
    }
}

// MARK: - MovieCoreDataControllerProvider
extension MovieCoreDataController: MovieCoreDataControllerProvider {
    
    public func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed fetch from core data")
        }
    }
    
    public func numberOfSection() -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    public func item(at indexPath: IndexPath) -> MovieModel {
        return fetchedResultsController.object(at: indexPath).toDomain()
    }
    
    public func filter(with text: String) {
        guard !text.isEmpty else {
            return changeBackToDefaultController()
        }
        
        createFilterController(with: text)
    }
}
