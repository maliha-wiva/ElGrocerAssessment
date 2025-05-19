//
//  LoginViewModel.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import Foundation
/// A view model responsible for handling login logic and user authentication.
///
/// `LoginViewModel` validates user credentials, manages authentication requests,
/// and stores authentication tokens securely using a keychain service.
/// It acts as an intermediary between the login view controller and authentication services.
protocol LoginViewModelProtocol {
    func validate(email: String, password: String) throws
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func isUserLoggedIn() -> Bool
}

class LoginViewModel: LoginViewModelProtocol {
    private let keychainService: KeychainServiceProtocol
    /// The validator used for validating email and password input.

    private let validator: ValidatorProtocol
    /// The authentication service used to perform login requests.

    private let authService: AuthServiceProtocol
    /// Initializes a new login view model with the required dependencies.
    ///
    /// - Parameters:
    ///   - keychainService: The keychain service for token storage.
    ///   - validator: The validator for input validation.
    ///   - authService: The authentication service for login requests.
    init(
        keychainService: KeychainServiceProtocol,
        validator: ValidatorProtocol,
        authService: AuthServiceProtocol
    ) {
        self.keychainService = keychainService
        self.validator = validator
        self.authService = authService
    }
    /// Validates the provided email and password.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    /// - Throws: An error if validation fails.
    func validate(email: String, password: String) throws {
        try validator.validateEmail(email)
        try validator.validatePassword(password)
    }
    /// Attempts to log in the user with the provided credentials.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///   - completion: A closure called with a result containing a boolean for success or an error on failure.
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        authService.login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                self.keychainService.saveToken(token)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    /// Checks if a user is currently logged in by verifying the presence of a stored token.
    ///
    /// - Returns: `true` if a token exists, otherwise `false`.
    func isUserLoggedIn() -> Bool {
        return keychainService.getToken() != nil
    }
}
