//
//  ProductCell.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import UIKit
/// A custom collection view cell for displaying product information.
///
/// `ProductCell` presents a product image, name, and price in a vertically stacked layout.
/// The image is loaded from the app bundle using the product's image URL string.
///
/// Use this cell in collection views to visually represent products in a grid or list.
///
/// - Note: For production, consider using asynchronous image loading and caching for remote images.
class ProductCell: UICollectionViewCell {
    /// The reuse identifier for the product cell.

    static let identifier = "ProductCell"
    /// The image view that displays the product image.

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    /// The label that displays the product name.

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    /// The label that displays the product price.

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGreen
        return label
    }()
    /// Initializes a new product cell with the specified frame.
    ///
    /// - Parameter frame: The frame rectangle for the cell, measured in points.
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4)
        ])
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    /// Required initializer with coder. Not implemented.

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Configures the cell to display the given product.
    ///
    /// - Parameter product: The `Product` object containing the name, price, and image URL.
    ///
    /// Loads the image from the app bundle using the image URL string.
    func configure(with product: Product) {
        imageView.image = UIImage(named: product.imageUrl) // Replace with actual image loading logic
        nameLabel.text = product.name
        priceLabel.text = "$\(product.price)"
    }
}
