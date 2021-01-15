//
//  Coordinator.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func finish()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinators()
}
