//
//  ProfileViewController.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let profileView = ProfileView()
    private let viewModel: ProfileViewModel
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let editProfileSubject = PassthroughSubject<Void, Never>()
    
    // Callback for coordinator navigation
    var onNavigateToEditProfile: (() -> Void)?
    
    // MARK: - Initialization
    
    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = profileView
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
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCallbacks() {
        profileView.onEditProfileTapped = { [weak self] in
            self?.editProfileSubject.send(())
            self?.onNavigateToEditProfile?()
        }
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        // Create input
        let input = ProfileViewModel.Input(
            viewDidLoadTrigger: viewDidLoadSubject.eraseToAnyPublisher(),
            editProfileTrigger: editProfileSubject.eraseToAnyPublisher()
        )
        
        // Transform input to output
        let output = viewModel.transform(input: input)
        
        // Bind outputs
        output.profileData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profileData in
                self?.profileView.configure(with: profileData)
            }
            .store(in: &cancellables)
        
        // Bind loading state
        bindLoading(viewModel)
            .store(in: &cancellables)
        
        // Bind error state
        bindError(viewModel)
            .store(in: &cancellables)
    }
}
