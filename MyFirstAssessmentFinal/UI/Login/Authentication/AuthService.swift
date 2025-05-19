//
//  AuthService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation

/// A service responsible for handling user authentication.
///
/// `AuthService` provides a method to log in a user asynchronously, simulating a network request.
/// On successful authentication, it returns a token; otherwise, it returns an error.
///
/// - Note: This implementation uses hardcoded credentials for demonstration purposes.
class AuthService: AuthServiceProtocol {
    /// Attempts to log in a user with the provided email and password.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///   - completion: A closure called with a result containing either a token string on success or an error on failure.
    ///
    /// The method simulates a network delay and checks credentials against hardcoded values.
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if email == "test@elgrocer.com" && password == "password123" {
                let token = UUID().uuidString
                completion(.success(token))
            } else {
                completion(.failure(AuthError.invalidCredentials))
            }
        }
    }
    /// Errors that can occur during authentication.

    enum AuthError: Error {
        /// The provided credentials are invalid.

        case invalidCredentials
    }
}
