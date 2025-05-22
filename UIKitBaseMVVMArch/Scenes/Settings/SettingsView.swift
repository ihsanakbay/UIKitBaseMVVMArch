//
//  SettingsView.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

final class SettingsView: BaseView {
    
    // MARK: - UI Components
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties
    
    var onSettingSelected: ((Int, Int) -> Void)?
    
    // MARK: - Setup
    
    override func setupHierarchy() {
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func setupProperties() {
        super.setupProperties()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Public Methods
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SettingsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .account:
            return AccountSetting.allCases.count
        case .appearance:
            return AppearanceSetting.allCases.count
        case .privacy:
            return PrivacySetting.allCases.count
        case .about:
            return AboutSetting.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return cell }
        
        var configuration = cell.defaultContentConfiguration()
        
        switch section {
        case .account:
            guard let setting = AccountSetting(rawValue: indexPath.row) else { return cell }
            configuration.text = setting.title
            configuration.image = setting.image
            
        case .appearance:
            guard let setting = AppearanceSetting(rawValue: indexPath.row) else { return cell }
            configuration.text = setting.title
            configuration.image = setting.image
            
        case .privacy:
            guard let setting = PrivacySetting(rawValue: indexPath.row) else { return cell }
            configuration.text = setting.title
            configuration.image = setting.image
            
        case .about:
            guard let setting = AboutSetting(rawValue: indexPath.row) else { return cell }
            configuration.text = setting.title
            configuration.image = setting.image
        }
        
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSection(rawValue: section) else { return nil }
        return section.title
    }
}

// MARK: - UITableViewDelegate

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSettingSelected?(indexPath.section, indexPath.row)
    }
}

// MARK: - Settings Enums

enum SettingsSection: Int, CaseIterable {
    case account
    case appearance
    case privacy
    case about
    
    var title: String {
        switch self {
        case .account:
            return "Account"
        case .appearance:
            return "Appearance"
        case .privacy:
            return "Privacy"
        case .about:
            return "About"
        }
    }
}

enum AccountSetting: Int, CaseIterable {
    case profile
    case notifications
    case logout
    
    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .notifications:
            return "Notifications"
        case .logout:
            return "Logout"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .profile:
            return UIImage(systemName: "person")
        case .notifications:
            return UIImage(systemName: "bell")
        case .logout:
            return UIImage(systemName: "arrow.right.square")
        }
    }
}

enum AppearanceSetting: Int, CaseIterable {
    case theme
    case textSize
    
    var title: String {
        switch self {
        case .theme:
            return "Theme"
        case .textSize:
            return "Text Size"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .theme:
            return UIImage(systemName: "paintbrush")
        case .textSize:
            return UIImage(systemName: "textformat.size")
        }
    }
}

enum PrivacySetting: Int, CaseIterable {
    case dataUsage
    case permissions
    
    var title: String {
        switch self {
        case .dataUsage:
            return "Data Usage"
        case .permissions:
            return "App Permissions"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .dataUsage:
            return UIImage(systemName: "chart.bar")
        case .permissions:
            return UIImage(systemName: "lock.shield")
        }
    }
}

enum AboutSetting: Int, CaseIterable {
    case version
    case terms
    case privacy
    
    var title: String {
        switch self {
        case .version:
            return "Version"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .version:
            return UIImage(systemName: "info.circle")
        case .terms:
            return UIImage(systemName: "doc.text")
        case .privacy:
            return UIImage(systemName: "hand.raised")
        }
    }
}
