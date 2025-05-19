//
//  AppInstallTracker.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation

/// Tracks the installation state of the app and manages keychain cleanup on first install.
///
/// Use this class to determine if the app is being launched for the first time and to clear any existing credentials from the keychain if needed.
class AppInstallTracker {
    /// Checks if this is the first install of the app and clears the keychain if necessary.
    ///
    /// This method uses `UserDefaults` to determine if the app has been launched before. If not, it sets the launch flag and calls the provided keychain service to clear any stored tokens.
    ///
    /// - Parameter keychainService: An object conforming to `KeychainServiceProtocol` used to clear stored credentials.
    static func checkFirstInstallAndClearKeychainIfNeeded(_ keychainService: KeychainServiceProtocol) {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if !hasLaunchedBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            keychainService.clearToken() // 💥 Clear old token
        }
    }
}
