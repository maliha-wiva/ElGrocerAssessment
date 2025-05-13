//
//  SceneDelegate.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let keychainService = KeychainService()
        appCoordinator = AppCoordinator(window: window, keychainService: keychainService)
        appCoordinator?.start()
        self.window = window
    }
}
