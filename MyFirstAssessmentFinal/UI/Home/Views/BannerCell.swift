//
//  Untitled.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit
/// A custom collection view cell for displaying a banner image.
///
/// `BannerCell` contains an image view that fills the cell and loads an image asynchronously from a given URL.
/// The cell is intended for use in banner carousels or similar UI components.
///
/// - Note: Image loading is performed asynchronously using `URLSession` and updates the UI on the main thread.
class BannerCell: UICollectionViewCell {
    /// The reuse identifier for the banner cell.

    static let identifier = "BannerCell"
    /// The image view that displays the banner image.

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    /// Initializes a new banner cell with the specified frame.
    ///
    /// - Parameter frame: The frame rectangle for the cell, measured in points.
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    /// Required initializer with coder. Not implemented.

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Configures the cell to display an image from the specified URL string.
    ///
    /// - Parameter imageUrl: The URL string of the image to display.
    ///
    /// The method loads the image asynchronously and sets it to the image view when loaded.
    func configure(with imageUrl: String) {
            guard let url = URL(string: imageUrl) else { return }
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                } catch {
                    print("Failed to load image: \(error)")
                }
            }
        }
}


