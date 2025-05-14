//
//  AuthService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation


class AuthService: AuthServiceProtocol {
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

    enum AuthError: Error {
        case invalidCredentials
    }
}
