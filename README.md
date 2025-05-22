# UIKit Base MVVM Architecture

A base architecture template for UIKit applications using MVVM pattern with Combine framework.

## Architecture Overview

This project follows the MVVM (Model-View-ViewModel) architectural pattern with the following components:

### Core Components

- **Model**: Data models and business logic
- **View**: UI components (UIViewController, UIView)
- **ViewModel**: Presentation logic and state management
- **Coordinator**: Navigation flow management

### Key Features

- Programmatic UI (no storyboards)
- Combine framework for reactive programming
- Dependency injection
- Coordinator pattern for navigation
- Logging system
- Network layer with Combine
- Base classes for common functionality

## Project Structure

```
UIKitBaseMVVMArch/
├── Core/
│   ├── Base/
│   │   ├── BaseView.swift
│   │   ├── BaseViewController.swift
│   │   ├── BaseViewModel.swift
│   │   └── Coordinator.swift
│   ├── Coordinators/
│   │   └── AppCoordinator.swift
│   ├── Extensions/
│   │   ├── Publisher+Extensions.swift
│   │   ├── UIView+Extensions.swift
│   │   └── UIViewController+Extensions.swift
│   ├── Network/
│   │   ├── Endpoint.swift
│   │   ├── NetworkError.swift
│   │   └── NetworkService.swift
│   └── Utilities/
│       ├── AppConfig.swift
│       ├── DependencyContainer.swift
│       ├── Logger.swift
│       └── UserPreferences.swift
├── Scenes/
│   └── Home/
│       ├── HomeCoordinator.swift
│       ├── HomeView.swift
│       ├── HomeViewController.swift
│       └── HomeViewModel.swift
└── App/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    └── Info.plist
```

## Usage Guide

### Creating a New Screen

1. Create a new folder in the Scenes directory for your feature
2. Create the following files:
   - `FeatureView.swift`: UI components and layout
   - `FeatureViewController.swift`: View controller logic
   - `FeatureViewModel.swift`: Business logic and state management
   - `FeatureCoordinator.swift`: Navigation for the feature

### Example View

```swift
final class FeatureView: BaseView {
    // UI components
    
    override func setupHierarchy() {
        // Add subviews
    }
    
    override func setupConstraints() {
        // Set up constraints
    }
    
    override func setupProperties() {
        super.setupProperties()
        // Configure properties
    }
}
```

### Example ViewModel

```swift
final class FeatureViewModel: BaseViewModel, ViewModelType {
    struct Input {
        // Define inputs
    }
    
    struct Output {
        // Define outputs
    }
    
    func transform(input: Input) -> Output {
        // Transform inputs to outputs
        return Output(...)
    }
}
```

### Example ViewController

```swift
final class FeatureViewController: BaseViewController {
    private let featureView = FeatureView()
    private let viewModel: FeatureViewModel
    
    init(viewModel: FeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = featureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        // Bind view model
    }
}
```

## Best Practices

1. Use the base classes for consistency
2. Implement the ViewModelType protocol for all view models
3. Use Combine for reactive programming
4. Use coordinators for navigation
5. Use dependency injection for testability
6. Log important events using the Logger
7. Keep views, view controllers, and view models focused on their responsibilities

## License

This project is available under the MIT license.
