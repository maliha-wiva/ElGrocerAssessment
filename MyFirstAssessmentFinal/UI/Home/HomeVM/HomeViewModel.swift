//
//  HomeViewModel.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var banners: [Banner] { get }
    var categories: [Category] { get }
    var products: [Product] { get }
    var bannersPublisher: Published<[Banner]>.Publisher { get }
    var categoriesPublisher: Published<[Category]>.Publisher { get }
    var productsPublisher: Published<[Product]>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    func fetchData()
}

class HomeViewModel: HomeViewModelProtocol {
    @Published private(set) var banners: [Banner] = [] {
        didSet {
            print("Banners property updated: \(banners)")
        }
    }
    @Published private(set) var categories: [Category] = [] {
        didSet {
            print("Categories property updated: \(categories)")
        }
    }
    @Published private(set) var products: [Product] = [] {
        didSet {
            print("Products property updated: \(products)")
        }
    }
    @Published private(set) var error: Error?

    var bannersPublisher: Published<[Banner]>.Publisher { $banners }
    var categoriesPublisher: Published<[Category]>.Publisher { $categories }
    var productsPublisher: Published<[Product]>.Publisher { $products }
    var errorPublisher: Published<Error?>.Publisher { $error }
    
    

    func fetchData() {
        fetchBanners()
        fetchCategories()
        fetchProducts()
    }

    private func fetchBanners() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.banners = [
                Banner(id: 1, imageUrl: "https://picsum.photos/800/300?random=1"),
                Banner(id: 2, imageUrl: "https://picsum.photos/800/300?random=2"),
                Banner(id: 3, imageUrl: "https://picsum.photos/800/300?random=3"),
                Banner(id: 4, imageUrl: "https://picsum.photos/800/300?random=4"),
                Banner(id: 5, imageUrl: "https://picsum.photos/800/300?random=5"),
                Banner(id: 6, imageUrl: "https://picsum.photos/800/300?random=6")
            ]
        }
    }

    private func fetchCategories() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            self.categories = [
                Category(id: 1, name: "Fresh Fruits", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 2, name: "Fresh Vegetables", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 3, name: "Dairy & Eggs", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 4, name: "Meat & Poultry", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 5, name: "Bakery", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 6, name: "Beverages", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 7, name: "Snacks & Chips", imageUrl: "https://picsum.photos/200/200?random=1"),
                Category(id: 8, name: "Frozen Foods", imageUrl: "https://picsum.photos/200/200?random=1")
            ]
        }
    }

    private func fetchProducts() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.products = (1...20).map {
                Product(id: $0, name: "Product \($0)", price: Double($0) * 10, imageUrl: "product\($0).jpg")
            }
        }
    }
}
