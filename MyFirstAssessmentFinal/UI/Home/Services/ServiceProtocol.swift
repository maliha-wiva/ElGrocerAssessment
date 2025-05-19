//
//  BannerServiceProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


/// A protocol defining the interface for fetching banner data.
///
/// Conforming types are responsible for asynchronously retrieving an array of `Banner` objects,
/// typically from a remote or local data source.
protocol BannerServiceProtocol {
    /// Fetches a list of banners asynchronously.
    ///
    /// - Parameter completion: A closure called with a result containing either an array of `Banner` objects or an error.
    func fetchBanners(completion: @escaping (Result<[Banner], Error>) -> Void)
}

/// A protocol defining the interface for fetching category data.
///
/// Conforming types are responsible for asynchronously retrieving an array of `Category` objects,
/// typically from a remote or local data source.
protocol CategoryServiceProtocol {
    /// Fetches a list of categories asynchronously.
    ///
    /// - Parameter completion: A closure called with a result containing either an array of `Category` objects or an error.
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

/// A protocol defining the interface for fetching product data.
///
/// Conforming types are responsible for asynchronously retrieving an array of `Product` objects,
/// typically from a remote or local data source.
protocol ProductServiceProtocol {
    /// Fetches a list of products asynchronously.
    ///
    /// - Parameter completion: A closure called with a result containing either an array of `Product` objects or an error.
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
