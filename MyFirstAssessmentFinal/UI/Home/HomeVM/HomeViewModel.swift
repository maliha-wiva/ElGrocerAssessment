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
    // MARK: - Published Properties

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
    // MARK: - Public Publishers

    var bannersPublisher: Published<[Banner]>.Publisher { $banners }
    var categoriesPublisher: Published<[Category]>.Publisher { $categories }
    var productsPublisher: Published<[Product]>.Publisher { $products }
    var errorPublisher: Published<Error?>.Publisher { $error }
    // MARK: - Dependencies
        private let bannerService: BannerServiceProtocol
        private let categoryService: CategoryServiceProtocol
        private let productService: ProductServiceProtocol

        // MARK: - Init
        init(bannerService: BannerServiceProtocol,
             categoryService: CategoryServiceProtocol,
             productService: ProductServiceProtocol) {
            self.bannerService = bannerService
            self.categoryService = categoryService
            self.productService = productService
        }

    func fetchData() {
        fetchBanners()
        fetchCategories()
        fetchProducts()
    }

    private func fetchBanners() {
            bannerService.fetchBanners { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let banners):
                        self?.banners = banners
                    case .failure(let error):
                        self?.error = error
                    }
                }
            }
        }

        private func fetchCategories() {
            categoryService.fetchCategories { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let categories):
                        self?.categories = categories
                    case .failure(let error):
                        self?.error = error
                    }
                }
            }
        }

        private func fetchProducts() {
            productService.fetchProducts { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let products):
                        self?.products = products
                    case .failure(let error):
                        self?.error = error
                    }
                }
            }
        }
}
