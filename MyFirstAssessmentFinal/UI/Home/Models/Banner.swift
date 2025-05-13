//
//  Model.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import Foundation

struct Banner {
    let id: Int
    let imageUrl: String
}

enum DataError: Error, LocalizedError {
    case failedToLoad

    var errorDescription: String? {
        switch self {
        case .failedToLoad: return "Failed to load data. Please try again."
        }
    }
}
