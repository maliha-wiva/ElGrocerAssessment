//
//  MockCategoryService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation
class MockCategoryService: CategoryServiceProtocol {
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
