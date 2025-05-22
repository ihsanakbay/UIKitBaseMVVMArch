//
//  SettingsViewModel.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import Combine

final class SettingsViewModel: BaseViewModel, ViewModelType {
    
    // MARK: - Input/Output
    
    struct Input {
        let viewDidLoadTrigger: AnyPublisher<Void, Never>
        let settingSelectedTrigger: AnyPublisher<(section: Int, row: Int), Never>
    }
    
    struct Output {
        let settingsLoaded: AnyPublisher<Void, Never>
    }
    
    // MARK: - Properties
    
    private let settingsLoadedSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - ViewModelType
    
    func transform(input: Input) -> Output {
        // Handle view did load trigger
        input.viewDidLoadTrigger
            .sink { [weak self] _ in
                self?.loadSettings()
            }
            .store(in: &cancellables)
        
        // Handle setting selected trigger
        input.settingSelectedTrigger
            .sink { [weak self] section, row in
                self?.handleSettingSelected(section: section, row: row)
            }
            .store(in: &cancellables)
        
        return Output(
            settingsLoaded: settingsLoadedSubject.eraseToAnyPublisher()
        )
    }
    
    // MARK: - Private Methods
    
    private func loadSettings() {
        Logger.info("Loading settings...")
        isLoading.send(true)
        
        // Simulate loading settings
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading.send(false)
                self.settingsLoadedSubject.send(())
                Logger.info("Settings loaded successfully")
            }
        }
    }
    
    private func handleSettingSelected(section: Int, row: Int) {
        guard let section = SettingsSection(rawValue: section) else { return }
        
        switch section {
        case .account:
            guard let setting = AccountSetting(rawValue: row) else { return }
            Logger.info("Account setting selected: \(setting.title)")
            
            if setting == .logout {
                handleLogout()
            }
            
        case .appearance:
            guard let setting = AppearanceSetting(rawValue: row) else { return }
            Logger.info("Appearance setting selected: \(setting.title)")
            
        case .privacy:
            guard let setting = PrivacySetting(rawValue: row) else { return }
            Logger.info("Privacy setting selected: \(setting.title)")
            
        case .about:
            guard let setting = AboutSetting(rawValue: row) else { return }
            Logger.info("About setting selected: \(setting.title)")
        }
    }
    
    private func handleLogout() {
        Logger.info("Logout requested")
        // In a real app, this would handle the logout process
        // and notify the coordinator to navigate to the login screen
    }
}
