//
//  Coordinator.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Protocol that all coordinators must conform to
protocol Coordinator: AnyObject {
    /// The navigation controller used by the coordinator
    var navigationController: UINavigationController { get }
    
    /// Child coordinators
    var childCoordinators: [Coordinator] { get set }
    
    /// Starts the coordinator
    func start()
    
    /// Adds a child coordinator
    /// - Parameter coordinator: The coordinator to add
    func addChildCoordinator(_ coordinator: Coordinator)
    
    /// Removes a child coordinator
    /// - Parameter coordinator: The coordinator to remove
    func removeChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}

/// Base class for all coordinators
class BaseCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Start method must be implemented by subclasses")
    }
}
