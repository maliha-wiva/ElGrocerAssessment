//
//  ValidatorProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import Foundation

protocol ValidatorProtocol {
    /// Validates the provided email address.
    ///
    /// - Parameter email: The email address to validate.
    /// - Throws: `ValidationError.invalidEmail` if the email is not in a valid format.
    func validateEmail(_ email: String) throws
    /// Validates the provided password.
    ///
    /// - Parameter password: The password to validate.
    /// - Throws: `ValidationError.weakPassword` if the password does not meet the minimum requirements.
    func validatePassword(_ password: String) throws
}
/// A concrete implementation of `ValidatorProtocol` that provides validation logic for email and password.
///
/// This class uses regular expressions to validate email format and checks password length for strength.
class Validator: ValidatorProtocol {
    /// Validates the provided email address using a regular expression.
    ///
    /// - Parameter email: The email address to validate.
    /// - Throws: `ValidationError.invalidEmail` if the email is not in a valid format.
    func validateEmail(_ email: String) throws {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            throw ValidationError.invalidEmail
        }
    }
    /// Validates the provided password for minimum length.
    ///
    /// - Parameter password: The password to validate.
    /// - Throws: `ValidationError.weakPassword` if the password is shorter than 8 characters.
    func validatePassword(_ password: String) throws {
        guard password.count >= 8 else {
            throw ValidationError.weakPassword
        }
    }
}
