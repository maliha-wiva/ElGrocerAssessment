class AppInstallTracker {
    static func checkFirstInstallAndClearKeychainIfNeeded(_ keychainService: KeychainServiceProtocol) {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if !hasLaunchedBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            keychainService.clearToken() // 💥 Clear old token
        }
    }
}
