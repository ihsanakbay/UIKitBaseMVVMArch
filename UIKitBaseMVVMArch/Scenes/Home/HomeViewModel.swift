//
//  HomeViewModel.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel: BaseViewModel, ViewModelType {
    
    // MARK: - Input/Output
    
    struct Input {
        let viewDidLoadTrigger: AnyPublisher<Void, Never>
        let refreshTrigger: AnyPublisher<Void, Never>
        let itemSelectedTrigger: AnyPublisher<HomeItem, Never>
    }
    
    struct Output {
        let items: AnyPublisher<[HomeItem], Never>
        let selectedItem: AnyPublisher<HomeItem, Never>
    }
    
    // MARK: - Properties
    
    private let itemsSubject = CurrentValueSubject<[HomeItem], Never>([])
    private let selectedItemSubject = PassthroughSubject<HomeItem, Never>()
    private let networkService: NetworkServiceType
    
    // MARK: - Initialization
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
        super.init()
    }
    
    // MARK: - ViewModelType
    
    func transform(input: Input) -> Output {
        // Handle view did load trigger
        input.viewDidLoadTrigger
            .sink { [weak self] _ in
                self?.fetchItems()
            }
            .store(in: &cancellables)
        
        // Handle refresh trigger
        input.refreshTrigger
            .sink { [weak self] _ in
                self?.fetchItems()
            }
            .store(in: &cancellables)
        
        // Handle item selection
        input.itemSelectedTrigger
            .sink { [weak self] item in
                self?.handleItemSelected(item)
            }
            .store(in: &cancellables)
        
        return Output(
            items: itemsSubject.eraseToAnyPublisher(),
            selectedItem: selectedItemSubject.eraseToAnyPublisher()
        )
    }
    
    // MARK: - Private Methods
    
    private func fetchItems() {
        Logger.info("Fetching home items...")
        isLoading.send(true)
        
        // Simulate network request
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            // In a real app, this would come from an API
            let mockItems = HomeItem.mockItems()
            
            DispatchQueue.main.async {
                self.isLoading.send(false)
                self.itemsSubject.send(mockItems)
                Logger.info("Fetched \(mockItems.count) home items successfully")
            }
            
            // Uncomment to simulate error
            /*
            DispatchQueue.main.async {
                self.isLoading.send(false)
                self.error.send(ViewModelError.network("Failed to fetch items"))
                Logger.error("Failed to fetch items")
            }
            */
        }
    }
    
    private func handleItemSelected(_ item: HomeItem) {
        Logger.info("Item selected: \(item.title)")
        selectedItemSubject.send(item)
    }
}
