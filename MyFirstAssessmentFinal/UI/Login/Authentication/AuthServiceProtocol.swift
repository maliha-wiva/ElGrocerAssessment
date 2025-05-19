//
//  AuthServiceProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

/// A protocol defining authentication service requirements.
///
/// `AuthServiceProtocol` specifies the interface for authentication services,
/// requiring a login method that performs user authentication asynchronously.
///
/// Types conforming to this protocol should implement the login logic and
/// return a result containing either a token string on success or an error on failure.
public protocol AuthServiceProtocol {
    /// Attempts to log in a user with the provided email and password.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///   - completion: A closure called with a result containing either a token string on success or an error on failure.
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
}
