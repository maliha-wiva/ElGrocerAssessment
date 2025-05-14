//
//  BannerServiceProtocol.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


protocol BannerServiceProtocol {
    func fetchBanners(completion: @escaping (Result<[Banner], Error>) -> Void)
}

protocol CategoryServiceProtocol {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
