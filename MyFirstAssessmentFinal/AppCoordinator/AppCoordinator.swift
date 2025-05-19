//
//  AppCoordinator.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit
/// The `AppCoordinator` is responsible for managing the main navigation flow of the app.
///
/// It determines the initial screen based on the user's authentication state and sets up the root view controller accordingly.
class AppCoordinator {
    /// The main window used to display the app's UI.
    
    ///
    private let window: UIWindow
    /// The service used for secure storage and retrieval of authentication tokens.

    private let keychainService: KeychainServiceProtocol
    /// Initializes a new instance of `AppCoordinator`.
    ///
    /// - Parameters:
    ///   - window: The main application window.
    ///   - keychainService: The keychain service for managing authentication tokens.
    init(window: UIWindow, keychainService: KeychainServiceProtocol) {
        self.window = window
        self.keychainService = keychainService
    }
    /// Starts the app's navigation flow.
    ///
    /// This method checks if the app is being launched for the first time and clears the keychain if needed.
    /// It then determines whether to show the home screen or the login screen based on the user's authentication state.
    func start() {
        AppInstallTracker.checkFirstInstallAndClearKeychainIfNeeded(KeychainService()) // Check if first install and clear keychain if needed. i Implemented this for the testing purposes if want to test the login functionality. and State the app is not installed before.
        if isUserLoggedIn() {
            showHome()
        } else {
            showLogin()
        }
    }
    /// Checks if the user is currently logged in.
    ///
    /// - Returns: `true` if a valid authentication token exists, otherwise `false`.
    private func isUserLoggedIn() -> Bool {
        return keychainService.getToken() != nil
    }
    /// Presents the login screen as the root view controller.

    private func showLogin() {
        let loginVC = createLoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    /// Presents the home screen as the root view controller.
    ///
    /// This method sets up mock services and injects them into the home view model.
    private func showHome() {
        // Instantiate services (can be real or mock)
        let bannerService = MockBannerService()
        let categoryService = MockCategoryService()
        let productService = MockProductService()

        // Inject services into HomeViewModel
        let homeViewModel: HomeViewModelProtocol = HomeViewModel(
            bannerService: bannerService,
            categoryService: categoryService,
            productService: productService
        )

        // Create home view controller with ViewModel
        let homeVC = createHomeViewController(viewModel: homeViewModel)

        // Set up navigation and window
        let navController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }

    /// Creates and returns a configured `LoginViewController`.
    ///
    /// - Returns: An instance of `LoginViewController` with its dependencies injected.
    private func createLoginViewController() -> LoginViewController {
        let validator = Validator()
        let authService = AuthService()
        let viewModel = LoginViewModel(
            keychainService: keychainService,
            validator: validator,
            authService: authService
        )
        return LoginViewController(viewModel: viewModel)
    }

    /// Creates and returns a configured `HomeViewController`.
    ///
    /// - Parameter viewModel: The view model to be used by the home view controller.
    /// - Returns: An instance of `HomeViewController` with its view model injected.
    private func createHomeViewController(viewModel: HomeViewModelProtocol) -> HomeViewController {
        return HomeViewController(viewModel: viewModel)
    }
}
