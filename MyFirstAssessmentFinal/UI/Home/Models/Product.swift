//
//  Product.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


/// A model representing a product displayed in the home screen.
///
/// Each product has a unique identifier, a display name, a price, and an image URL for UI presentation.
struct Product {
    /// The unique identifier for the product.
    let id: Int
    /// The display name of the product.
    let name: String
    /// The price of the product.
    let price: Double
    /// The URL string of the product image.
    let imageUrl: String
}
