//
//  ProfileViewModel.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

final class ProfileViewModel: BaseViewModel, ViewModelType {
    
    // MARK: - Models
    
    struct ProfileData {
        let name: String
        let email: String
        let image: UIImage?
    }
    
    // MARK: - Input/Output
    
    struct Input {
        let viewDidLoadTrigger: AnyPublisher<Void, Never>
        let editProfileTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let profileData: AnyPublisher<ProfileData, Never>
    }
    
    // MARK: - Properties
    
    private let profileDataSubject = CurrentValueSubject<ProfileData, Never>(
        ProfileData(
            name: "John Doe",
            email: "john.doe@example.com",
            image: UIImage(systemName: "person.circle.fill")
        )
    )
    
    // MARK: - Initialization
    
    override init() {
        super.init()
    }
    
    // MARK: - ViewModelType
    
    func transform(input: Input) -> Output {
        // Handle view did load trigger
        input.viewDidLoadTrigger
            .sink { [weak self] _ in
                self?.fetchProfileData()
            }
            .store(in: &cancellables)
        
        // Handle edit profile trigger
        input.editProfileTrigger
            .sink { [weak self] _ in
                self?.editProfile()
            }
            .store(in: &cancellables)
        
        return Output(
            profileData: profileDataSubject.eraseToAnyPublisher()
        )
    }
    
    // MARK: - Private Methods
    
    private func fetchProfileData() {
        Logger.info("Fetching profile data...")
        isLoading.send(true)
        
        // Simulate network request
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            // In a real app, this would come from an API or local database
            let mockProfile = ProfileData(
                name: "John Doe",
                email: "john.doe@example.com",
                image: UIImage(systemName: "person.circle.fill")
            )
            
            DispatchQueue.main.async {
                self.isLoading.send(false)
                self.profileDataSubject.send(mockProfile)
                Logger.info("Profile data fetched successfully")
            }
        }
    }
    
    private func editProfile() {
        Logger.info("Edit profile action triggered")
        // In a real app, this would navigate to an edit profile screen
        // or show an edit profile form
    }
}
