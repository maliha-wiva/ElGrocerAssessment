//
//  User.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import Foundation

struct User {
    let email: String
    let password: String
}

enum ValidationError: Error, LocalizedError {
    case invalidEmail
    case weakPassword

    var errorDescription: String? {
        switch self {
        case .invalidEmail: return "Invalid email format."
        case .weakPassword: return "Password must be at least 8 characters long."
        }
    }
}
