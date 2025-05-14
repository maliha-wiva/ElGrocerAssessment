//
//  LoginViewModel.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import Foundation

protocol LoginViewModelProtocol {
    func validate(email: String, password: String) throws
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func isUserLoggedIn() -> Bool
}

class LoginViewModel: LoginViewModelProtocol {
    private let keychainService: KeychainServiceProtocol
    private let validator: ValidatorProtocol
    private let authService: AuthServiceProtocol

    init(
        keychainService: KeychainServiceProtocol,
        validator: ValidatorProtocol,
        authService: AuthServiceProtocol
    ) {
        self.keychainService = keychainService
        self.validator = validator
        self.authService = authService
    }

    func validate(email: String, password: String) throws {
        try validator.validateEmail(email)
        try validator.validatePassword(password)
    }

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

    func isUserLoggedIn() -> Bool {
        return keychainService.getToken() != nil
    }
}
