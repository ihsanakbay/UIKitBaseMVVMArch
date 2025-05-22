//
//  ProfileCoordinator.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Coordinator for the Profile module
final class ProfileCoordinator: BaseCoordinator {
    
    // MARK: - Coordinator
    
    override func start() {
        Logger.info("Starting ProfileCoordinator")
        showProfileViewController()
    }
    
    // MARK: - Navigation
    
    private func showProfileViewController() {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        
        // Add navigation to edit profile screen
        viewController.onNavigateToEditProfile = { [weak self] in
            self?.showEditProfileViewController()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showEditProfileViewController() {
        // In a real app, this would navigate to an edit profile screen
        Logger.info("Would navigate to edit profile screen")
        
        // Example implementation:
        // let editProfileViewController = EditProfileViewController()
        // navigationController.pushViewController(editProfileViewController, animated: true)
    }
}
