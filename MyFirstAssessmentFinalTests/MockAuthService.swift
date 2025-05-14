//
//  MockAuthService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation


class MockAuthService: AuthServiceProtocol {
    var shouldSucceed = true

    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if self.shouldSucceed {
                completion(.success("mockAuthToken"))
            } else {
                completion(.failure(NSError(domain: "Invalid credentials", code: 401)))
            }
        }
    }
}
