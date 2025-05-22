//
//  SettingsViewController.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

final class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let settingsView = SettingsView()
    private let viewModel: SettingsViewModel
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let settingSelectedSubject = PassthroughSubject<(section: Int, row: Int), Never>()
    
    // Callbacks for coordinator navigation
    var onNavigateToAccountSetting: ((AccountSetting) -> Void)?
    var onNavigateToAppearanceSetting: ((AppearanceSetting) -> Void)?
    var onNavigateToPrivacySetting: ((PrivacySetting) -> Void)?
    var onNavigateToAboutSetting: ((AboutSetting) -> Void)?
    var onLogout: (() -> Void)?
    
    // MARK: - Initialization
    
    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        bindViewModel()
        setupCallbacks()
        
        // Trigger view did load
        viewDidLoadSubject.send(())
    }
    
    // MARK: - Setup
    
    private func setupNavigation() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCallbacks() {
        settingsView.onSettingSelected = { [weak self] section, row in
            self?.handleSettingSelected(section: section, row: row)
        }
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        // Create input
        let input = SettingsViewModel.Input(
            viewDidLoadTrigger: viewDidLoadSubject.eraseToAnyPublisher(),
            settingSelectedTrigger: settingSelectedSubject.eraseToAnyPublisher()
        )
        
        // Transform input to output
        let output = viewModel.transform(input: input)
        
        // Bind outputs
        output.settingsLoaded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.settingsView.reloadData()
            }
            .store(in: &cancellables)
        
        // Bind loading state
        bindLoading(viewModel)
            .store(in: &cancellables)
        
        // Bind error state
        bindError(viewModel)
            .store(in: &cancellables)
    }
    
    // MARK: - Private Methods
    
    private func handleSettingSelected(section: Int, row: Int) {
        // Forward to view model
        settingSelectedSubject.send((section: section, row: row))
        
        // Handle navigation via coordinator
        guard let section = SettingsSection(rawValue: section) else { return }
        
        switch section {
        case .account:
            guard let setting = AccountSetting(rawValue: row) else { return }
            
            if setting == .logout {
                onLogout?()
            } else {
                onNavigateToAccountSetting?(setting)
            }
            
        case .appearance:
            guard let setting = AppearanceSetting(rawValue: row) else { return }
            onNavigateToAppearanceSetting?(setting)
            
        case .privacy:
            guard let setting = PrivacySetting(rawValue: row) else { return }
            onNavigateToPrivacySetting?(setting)
            
        case .about:
            guard let setting = AboutSetting(rawValue: row) else { return }
            onNavigateToAboutSetting?(setting)
        }
    }
}
