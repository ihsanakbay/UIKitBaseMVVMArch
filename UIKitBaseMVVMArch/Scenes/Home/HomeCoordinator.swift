//
//  HomeCoordinator.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Coordinator for the Home module
final class HomeCoordinator: BaseCoordinator {
    
    // MARK: - Coordinator
    
    override func start() {
        Logger.info("Starting HomeCoordinator")
        showHomeViewController()
    }
    
    // MARK: - Navigation
    
    private func showHomeViewController() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        
        // Add navigation to detail screen
        viewController.onNavigateToDetail = { [weak self] item in
            self?.showDetailViewController(item: item)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showDetailViewController(item: HomeItem) {
        let detailViewController = HomeDetailViewController(item: item)
        navigationController.pushViewController(detailViewController, animated: true)
        Logger.info("Navigated to detail for item: \(item.title)")
    }
}
