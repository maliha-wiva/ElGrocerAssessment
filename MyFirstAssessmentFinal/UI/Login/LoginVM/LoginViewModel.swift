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

import Foundation

class LoginViewModel: LoginViewModelProtocol {
    private let keychainService: KeychainServiceProtocol
    private let validator: ValidatorProtocol
    private let mockEmail = "test@example.com"
    private let mockPassword = "password123"

    init(keychainService: KeychainServiceProtocol, validator: ValidatorProtocol) {
        self.keychainService = keychainService
        self.validator = validator
    }

    func validate(email: String, password: String) throws {
        try validator.validateEmail(email)
        try validator.validatePassword(password)
    }

    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            if email == self.mockEmail && password == self.mockPassword {
                self.keychainService.saveToken("mockAuthToken")
                completion(.success(true))
            } else {
                completion(.failure(NSError(domain: "Invalid credentials", code: 401, userInfo: nil)))
            }
        }
    }

    func isUserLoggedIn() -> Bool {
        return keychainService.getToken() != nil
    }
}
