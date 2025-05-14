//
//  MockBannerService.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 14.05.2025.
//

import Foundation

class MockBannerService: BannerServiceProtocol {
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
