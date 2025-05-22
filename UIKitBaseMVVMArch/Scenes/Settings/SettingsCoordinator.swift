//
//  SettingsCoordinator.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Coordinator for the Settings module
final class SettingsCoordinator: BaseCoordinator {
    
    // MARK: - Coordinator
    
    override func start() {
        Logger.info("Starting SettingsCoordinator")
        showSettingsViewController()
    }
    
    // MARK: - Navigation
    
    private func showSettingsViewController() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        
        // Add navigation callbacks
        viewController.onNavigateToAccountSetting = { [weak self] setting in
            self?.navigateToAccountSetting(setting)
        }
        
        viewController.onNavigateToAppearanceSetting = { [weak self] setting in
            self?.navigateToAppearanceSetting(setting)
        }
        
        viewController.onNavigateToPrivacySetting = { [weak self] setting in
            self?.navigateToPrivacySetting(setting)
        }
        
        viewController.onNavigateToAboutSetting = { [weak self] setting in
            self?.navigateToAboutSetting(setting)
        }
        
        viewController.onLogout = { [weak self] in
            self?.handleLogout()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToAccountSetting(_ setting: AccountSetting) {
        Logger.info("Would navigate to account setting: \(setting.title)")
        // In a real app, this would navigate to the appropriate screen
    }
    
    private func navigateToAppearanceSetting(_ setting: AppearanceSetting) {
        Logger.info("Would navigate to appearance setting: \(setting.title)")
        // In a real app, this would navigate to the appropriate screen
    }
    
    private func navigateToPrivacySetting(_ setting: PrivacySetting) {
        Logger.info("Would navigate to privacy setting: \(setting.title)")
        // In a real app, this would navigate to the appropriate screen
    }
    
    private func navigateToAboutSetting(_ setting: AboutSetting) {
        Logger.info("Would navigate to about setting: \(setting.title)")
        // In a real app, this would navigate to the appropriate screen
    }
    
    private func handleLogout() {
        Logger.info("Handling logout")
        // In a real app, this would handle the logout process
        // and navigate to the login screen
    }
}
