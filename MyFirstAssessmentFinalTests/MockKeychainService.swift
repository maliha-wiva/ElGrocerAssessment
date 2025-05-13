//
//  MockKeychainService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import Foundation
@testable import MyFirstAssessmentFinal

class MockKeychainService: KeychainServiceProtocol {
    var savedToken: String?

    func saveToken(_ token: String) {
        savedToken = token
    }

    func getToken() -> String? {
        return savedToken
    }

    func clearToken() {
        savedToken = nil
    }
}

class MockValidator: ValidatorProtocol {
    var shouldThrowEmailError = false
    var shouldThrowPasswordError = false

    func validateEmail(_ email: String) throws {
        if shouldThrowEmailError {
            throw ValidationError.invalidEmail
        }
    }

    func validatePassword(_ password: String) throws {
        if shouldThrowPasswordError {
            throw ValidationError.weakPassword
        }
    }
}
