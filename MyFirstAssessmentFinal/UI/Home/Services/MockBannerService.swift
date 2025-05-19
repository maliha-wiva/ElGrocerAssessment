//
//  MockBannerService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation

/// A mock implementation of `BannerServiceProtocol` for testing and development purposes.
///
/// `MockBannerService` simulates fetching banners by returning a predefined list of `Banner` objects
/// after a short delay, mimicking a network request.
///
/// Use this service in place of a real network service to provide consistent and predictable data during UI development or testing.
class MockBannerService: BannerServiceProtocol {
    /// Fetches a list of mock banners asynchronously.
    ///
    /// - Parameter completion: A closure called with a result containing either an array of `Banner` objects or an error.
    ///
    /// The method simulates a network delay of 1 second before returning the mock data.
    func fetchBanners(completion: @escaping (Result<[Banner], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(.success([
                Banner(id: 1, imageUrl: "https://picsum.photos/800/300?random=1"),
                Banner(id: 2, imageUrl: "https://picsum.photos/800/300?random=2"),
                Banner(id: 3, imageUrl: "https://picsum.photos/800/300?random=3"),
                Banner(id: 4, imageUrl: "https://picsum.photos/800/300?random=4"),
                Banner(id: 5, imageUrl: "https://picsum.photos/800/300?random=5"),
                Banner(id: 6, imageUrl: "https://picsum.photos/800/300?random=6")
            ]))
        }
    }
}
