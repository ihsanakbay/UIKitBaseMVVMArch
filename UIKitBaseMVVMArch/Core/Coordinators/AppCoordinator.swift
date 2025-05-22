//
//  AppCoordinator.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Main coordinator for the application
final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow
    
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        super.init(navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Coordinator
    
    override func start() {
        Logger.info("Starting AppCoordinator")
        showTabBar()
    }
    
    // MARK: - Navigation
    
    private func showTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
