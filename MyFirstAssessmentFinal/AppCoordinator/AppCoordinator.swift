//
//  AppCoordinator.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let keychainService: KeychainServiceProtocol

    init(window: UIWindow, keychainService: KeychainServiceProtocol) {
        self.window = window
        self.keychainService = keychainService
    }

    func start() {
        AppInstallTracker.checkFirstInstallAndClearKeychainIfNeeded(KeychainService()) // Check if first install and clear keychain if needed. i Implemented this for the testing purposes if want to test the login functionality. and State the app is not installed before.
        if isUserLoggedIn() {
            showHome()
        } else {
            showLogin()
        }
    }

    private func isUserLoggedIn() -> Bool {
        return keychainService.getToken() != nil
    }

    private func showLogin() {
        let loginVC = createLoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }

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


    private func createHomeViewController(viewModel: HomeViewModelProtocol) -> HomeViewController {
        return HomeViewController(viewModel: viewModel)
    }
}
