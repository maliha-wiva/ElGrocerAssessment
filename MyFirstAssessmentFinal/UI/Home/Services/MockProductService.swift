//
//  MockProductService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation
/// A mock implementation of `ProductServiceProtocol` for testing and development.
///
/// `MockProductService` simulates fetching products by returning a predefined list of `Product` objects
/// after a short delay, mimicking a network request.
///
/// Use this service to provide consistent and predictable product data during UI development or testing.
class MockProductService: ProductServiceProtocol {
    /// Fetches a list of mock products asynchronously.
    ///
    /// - Parameter completion: A closure called with a result containing either an array of `Product` objects or an error.
    ///
    /// The method simulates a network delay of 1 second before returning the mock data.
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let products = (1...20).map {
                Product(id: $0, name: "Product \($0)", price: Double($0) * 10, imageUrl: "product\($0).jpg")
            }
            completion(.success(products))
        }
    }
}
