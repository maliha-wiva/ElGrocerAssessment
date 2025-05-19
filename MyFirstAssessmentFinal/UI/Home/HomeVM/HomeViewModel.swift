//
//  HomeViewModel.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import Foundation
import Combine
/// A protocol defining the interface for the home screen view model.
///
/// `HomeViewModelProtocol` exposes publishers and data for banners, categories, and products,
/// as well as a method to fetch all required data for the home screen.
protocol HomeViewModelProtocol {
    
    /// The current list of banners.

    var banners: [Banner] { get }
    /// The current list of categories.

    var categories: [Category] { get }
    /// The current list of products.

    var products: [Product] { get }
    /// A publisher that emits updates to the banners array.

    var bannersPublisher: Published<[Banner]>.Publisher { get }
    /// A publisher that emits updates to the categories array.

    var categoriesPublisher: Published<[Category]>.Publisher { get }
    /// A publisher that emits updates to the products array.

    var productsPublisher: Published<[Product]>.Publisher { get }
    /// A publisher that emits errors encountered during data fetching.

    var errorPublisher: Published<Error?>.Publisher { get }
    /// Fetches banners, categories, and products for the home screen.

    func fetchData()
}
/// The view model responsible for managing and providing data for the home screen.
///
/// `HomeViewModel` fetches banners, categories, and products from their respective services,
/// exposes publishers for UI binding, and handles error propagation.
class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Published Properties
    /// The current list of banners.

    @Published private(set) var banners: [Banner] = [] {
        didSet {
            print("Banners property updated: \(banners)")
        }
    }
    /// The current list of categories.

    @Published private(set) var categories: [Category] = [] {
        didSet {
            print("Categories property updated: \(categories)")
        }
    }
    /// The current list of products.

    @Published private(set) var products: [Product] = [] {
        didSet {
            print("Products property updated: \(products)")
        }
    }
    /// The most recent error encountered during data fetching.

    @Published private(set) var error: Error?
    // MARK: - Public Publishers
    /// A publisher that emits updates to the banners array.

    var bannersPublisher: Published<[Banner]>.Publisher { $banners }
    /// A publisher that emits updates to the categories array.

    var categoriesPublisher: Published<[Category]>.Publisher { $categories }
    /// A publisher that emits updates to the products array.

    var productsPublisher: Published<[Product]>.Publisher { $products }
    /// A publisher that emits errors encountered during data fetching.

    var errorPublisher: Published<Error?>.Publisher { $error }
    // MARK: - Dependencies
    /// The service used to fetch banners.

        private let bannerService: BannerServiceProtocol
    /// The service used to fetch categories.

        private let categoryService: CategoryServiceProtocol
    /// The service used to fetch products.

        private let productService: ProductServiceProtocol

    // MARK: - Initialization

    /// Initializes a new instance of `HomeViewModel` with the given services.
    ///
    /// - Parameters:
    ///   - bannerService: The service for fetching banners.
    ///   - categoryService: The service for fetching categories.
    ///   - productService: The service for fetching products.
        init(bannerService: BannerServiceProtocol,
             categoryService: CategoryServiceProtocol,
             productService: ProductServiceProtocol) {
            self.bannerService = bannerService
            self.categoryService = categoryService
            self.productService = productService
        }
    // MARK: - Data Fetching

    /// Fetches banners, categories, and products for the home screen.
    ///
    /// This method triggers asynchronous requests to all three services and updates the published properties accordingly.
    func fetchData() {
        fetchBanners()
        fetchCategories()
        fetchProducts()
    }
    /// Fetches banners from the banner service and updates the `banners` property.

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
    /// Fetches categories from the category service and updates the `categories` property.

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
    /// Fetches products from the product service and updates the `products` property.

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
