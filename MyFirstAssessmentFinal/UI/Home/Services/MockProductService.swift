//
//  MockProductService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation
class MockProductService: ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let products = (1...20).map {
                Product(id: $0, name: "Product \($0)", price: Double($0) * 10, imageUrl: "product\($0).jpg")
            }
            completion(.success(products))
        }
    }
}
