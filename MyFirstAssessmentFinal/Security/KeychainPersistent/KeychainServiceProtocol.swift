//
//  KeychainServiceProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import Foundation
import Security
/// A protocol that defines methods for securely saving, retrieving, and clearing authentication tokens using the Keychain.

protocol KeychainServiceProtocol {
    /// Saves the provided authentication token to the Keychain.
    ///
    /// - Parameter token: The authentication token to be securely stored.
    func saveToken(_ token: String)
    
    /// Retrieves the authentication token from the Keychain, if it exists.
    ///
    /// - Returns: The stored authentication token, or `nil` if not found.
    func getToken() -> String?
    
    /// Removes the authentication token from the Keychain.
    func clearToken()
}
/// A concrete implementation of `KeychainServiceProtocol` that manages authentication tokens using the Keychain.
///
/// This class provides methods to securely save, retrieve, and clear tokens, ensuring data is only accessible when the device is unlocked with a passcode.
class KeychainService: KeychainServiceProtocol {
    /// The key used to identify the authentication token in the Keychain.

    private let tokenKey = "authToken"
    /// Saves the provided authentication token to the Keychain.
    ///
    /// - Parameter token: The authentication token to be securely stored.
    func saveToken(_ token: String) {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    /// Retrieves the authentication token from the Keychain, if it exists.
    ///
    /// - Returns: The stored authentication token, or `nil` if not found.
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        guard status == errSecSuccess, let data = dataTypeRef as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    /// Removes the authentication token from the Keychain.

    func clearToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
