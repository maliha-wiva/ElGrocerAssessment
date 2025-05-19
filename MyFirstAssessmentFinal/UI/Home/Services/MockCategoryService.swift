//
//  MockCategoryService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation
/// A mock implementation of `CategoryServiceProtocol` for testing and development.
///
/// `MockCategoryService` simulates fetching categories by returning a predefined list of `Category` objects
/// after a short delay, mimicking a network request.
///
/// Use this service to provide consistent and predictable category data during UI development or testing.
class MockCategoryService: CategoryServiceProtocol {
    /// Fetches a list of mock categories asynchronously.
    ///
    /// - Parameter completion: A closure called with a result containing either an array of `Category` objects or an error.
    ///
    /// The method simulates a network delay of 0.5 seconds before returning the mock data.
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let categories = [
                Category(id: 1, name: "Fresh Fruits", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 2, name: "Fresh Vegetables", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 3, name: "Dairy & Eggs", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 4, name: "Meat & Poultry", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 5, name: "Bakery", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 6, name: "Beverages", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 7, name: "Snacks & Chips", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 8, name: "Frozen Foods", imageUrl: "https://picsum.photos/200/200?random=1")
            ]
            completion(.success(categories))
        }
    }
}
