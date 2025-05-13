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
        let homeViewModel: HomeViewModelProtocol = HomeViewModel()
        let homeVC = createHomeViewController(viewModel: homeViewModel)
        let navController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }

    private func createLoginViewController() -> LoginViewController {
        let validator = Validator()
        let viewModel = LoginViewModel(keychainService: keychainService, validator: validator)
        return LoginViewController(viewModel: viewModel)
    }

    private func createHomeViewController(viewModel: HomeViewModelProtocol) -> HomeViewController {
        return HomeViewController(viewModel: viewModel)
    }
}
