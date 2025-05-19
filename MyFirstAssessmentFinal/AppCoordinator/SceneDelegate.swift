//
//  SceneDelegate.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit

/// The `SceneDelegate` is responsible for managing the app's main window and coordinating the initial app flow.
///
/// This class sets up the main window, initializes the `AppCoordinator`, and starts the app's navigation flow.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    /// The main window for displaying the app's UI.

    var window: UIWindow?
    /// The main coordinator responsible for handling navigation and app flow.
    var appCoordinator: AppCoordinator?
    /// Called when the scene is being created and connected to the app.
        ///
        /// - Parameters:
        ///   - scene: The scene object representing the app's UI.
        ///   - session: The session associated with the scene.
        ///   - connectionOptions: Additional options for configuring the scene.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let keychainService = KeychainService()
        appCoordinator = AppCoordinator(window: window, keychainService: keychainService)
        appCoordinator?.start()
        self.window = window
    }
}
