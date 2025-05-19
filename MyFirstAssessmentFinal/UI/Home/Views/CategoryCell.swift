//
//  CategoryCell.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit
/// A custom collection view cell for displaying a category with an image and name.
///
/// `CategoryCell` presents a category image and its name in a vertically stacked layout.
/// The image is loaded asynchronously from a URL, and a placeholder is shown if loading fails.
///
/// Use this cell in collection views to visually represent categories.
///
/// - Note: For production, consider using an image caching library for better performance.
class CategoryCell: UICollectionViewCell {
    /// The reuse identifier for the category cell.

    static let identifier = "CategoryCell"
    /// The image view that displays the category image.

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    /// The label that displays the category name.

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /// Initializes a new category cell with the specified frame.
    ///
    /// - Parameter frame: The frame rectangle for the cell, measured in points.
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -6)
        ])
    }
    /// Required initializer with coder. Not implemented.

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Configures the cell to display the given category.
    ///
    /// - Parameter category: The `Category` object containing the name and image URL.
    ///
    /// Loads the image asynchronously and sets it to the image view. If loading fails, a placeholder image is shown.
    func configure(with category: Category) {
        nameLabel.text = category.name
        if let url = URL(string: category.imageUrl) {
            // Load image asynchronously (for production, use SDWebImage or Kingfisher)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(systemName: "photo")
                    }
                }
            }
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
}
