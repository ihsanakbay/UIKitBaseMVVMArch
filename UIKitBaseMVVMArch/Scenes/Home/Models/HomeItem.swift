//
//  HomeItem.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import UIKit

/// Model representing an item in the home screen
struct HomeItem: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let image: UIImage?
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        image: UIImage? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.createdAt = createdAt
    }
    
    /// Creates mock items for testing
    static func mockItems() -> [HomeItem] {
        return [
            HomeItem(
                title: "Getting Started",
                description: "Learn how to use the MVVM architecture with UIKit and Combine",
                image: UIImage(systemName: "star.fill"),
                createdAt: Date().addingTimeInterval(-86400 * 2)
            ),
            HomeItem(
                title: "Networking",
                description: "Implement network requests using Combine publishers",
                image: UIImage(systemName: "network"),
                createdAt: Date().addingTimeInterval(-86400)
            ),
            HomeItem(
                title: "UI Components",
                description: "Create reusable UI components with programmatic layout",
                image: UIImage(systemName: "rectangle.3.group.fill"),
                createdAt: Date()
            ),
            HomeItem(
                title: "Testing",
                description: "Write unit tests for your view models and coordinators",
                image: UIImage(systemName: "checkmark.seal.fill"),
                createdAt: Date().addingTimeInterval(-86400 * 3)
            ),
            HomeItem(
                title: "Advanced Patterns",
                description: "Explore advanced patterns like dependency injection and reactive programming",
                image: UIImage(systemName: "gear.circle.fill"),
                createdAt: Date().addingTimeInterval(-86400 * 4)
            )
        ]
    }
}
