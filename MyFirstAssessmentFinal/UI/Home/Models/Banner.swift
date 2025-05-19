//
//  Model.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import Foundation
/// A model representing a banner displayed in the home screen.
///
/// Each banner has a unique identifier and an image URL to be shown in the UI.
struct Banner {
    /// The unique identifier for the banner.

    let id: Int
    /// The URL string of the banner image.

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
