//
//  ValidatorProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import Foundation

protocol ValidatorProtocol {
    func validateEmail(_ email: String) throws
    func validatePassword(_ password: String) throws
}

class Validator: ValidatorProtocol {
    func validateEmail(_ email: String) throws {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            throw ValidationError.invalidEmail
        }
    }

    func validatePassword(_ password: String) throws {
        guard password.count >= 8 else {
            throw ValidationError.weakPassword
        }
    }
}