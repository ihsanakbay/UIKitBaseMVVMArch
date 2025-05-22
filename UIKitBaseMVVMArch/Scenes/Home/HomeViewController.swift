//
//  HomeViewController.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let refreshSubject = PassthroughSubject<Void, Never>()
    private let itemSelectedSubject = PassthroughSubject<HomeItem, Never>()
    
    // Callback for coordinator navigation
    var onNavigateToDetail: ((HomeItem) -> Void)?
    
    // MARK: - Initialization
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = homeView
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
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCallbacks() {
        homeView.onRefreshRequested = { [weak self] in
            self?.refreshSubject.send(())
        }
        
        homeView.onItemSelected = { [weak self] item in
            self?.itemSelectedSubject.send(item)
        }
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        // Create input
        let input = HomeViewModel.Input(
            viewDidLoadTrigger: viewDidLoadSubject.eraseToAnyPublisher(),
            refreshTrigger: refreshSubject.eraseToAnyPublisher(),
            itemSelectedTrigger: itemSelectedSubject.eraseToAnyPublisher()
        )
        
        // Transform input to output
        let output = viewModel.transform(input: input)
        
        // Bind outputs
        output.items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.homeView.configure(with: items)
            }
            .store(in: &cancellables)
        
        // Bind selected item for navigation
        output.selectedItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.onNavigateToDetail?(item)
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
