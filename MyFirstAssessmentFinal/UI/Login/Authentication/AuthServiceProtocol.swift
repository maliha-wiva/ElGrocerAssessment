//
//  AuthServiceProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//


public protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
}
