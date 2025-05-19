//
//  HomeViewController.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit
import Combine
/// A view controller that displays banners, categories, and products in a compositional collection view layout.
///
/// `HomeViewController` manages the UI for the home screen, including auto-scrolling banners, category and product sections, and error handling.
/// It binds to a `HomeViewModelProtocol` to fetch and display data reactively.
class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    /// The timer used for auto-scrolling the banner section.

    private var timer: Timer?
    /// The current index of the visible banner.

    private var currentIndex = 0
    /// The view model providing data for banners, categories, and products.

    private var viewModel: HomeViewModelProtocol
    /// A set of Combine cancellables for managing subscriptions.

    private var cancellables = Set<AnyCancellable>()
    /// The main collection view displaying all sections.

    private var collectionView: UICollectionView!
    /// Initializes a new instance of `HomeViewController` with the given view model.
    ///
    /// - Parameter viewModel: The view model conforming to `HomeViewModelProtocol`.
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    /// Not implemented. Use `init(viewModel:)` instead.

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Called after the controller's view is loaded into memory.
    ///
    /// Sets up the collection view, binds the view model, fetches data, and starts banner auto-scrolling.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        bindViewModel()
        viewModel.fetchData()
        startAutoScrolling()
    }
    /// Starts the timer for auto-scrolling the banner section.

    private func startAutoScrolling() {
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.scrollToNextBanner()
            }
        }
    /// Stops the auto-scrolling timer.
        private func stopAutoScrolling() {
            timer?.invalidate()
            timer = nil
        }
    /// Scrolls the collection view to the next banner.

        private func scrollToNextBanner() {
            guard !viewModel.banners.isEmpty else { return }
            currentIndex = (currentIndex + 1) % viewModel.banners.count
            let indexPath = IndexPath(item: currentIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    /// Configures and adds the collection view to the view hierarchy.

    private func setupCollectionView() {
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .black
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    /// Binds the view model publishers to update the collection view and handle errors.

    private func bindViewModel() {
        viewModel.bannersPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.collectionView.reloadData() }
            .store(in: &cancellables)

        viewModel.categoriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.collectionView.reloadData() }
            .store(in: &cancellables)

        viewModel.productsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.collectionView.reloadData() }
            .store(in: &cancellables)

        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showError(error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
    /// Presents an alert with the given error message.
    ///
    /// - Parameter message: The error message to display.
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    /// Creates and returns the compositional layout for the collection view.
    ///
    /// - Returns: A configured `UICollectionViewLayout` with sections for banners, categories, and products.
    private func createCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self,
                  let section = HomeSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .banners:
                return self.createBannerSection()
            case .categories:
                return self.createCategorySection()
            case .products:
                return self.createProductSection()
            }
        }
    }
    /// Creates the layout section for banners.
    ///
    /// - Returns: A `NSCollectionLayoutSection` configured for banners.
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    /// Creates the layout section for categories.
    ///
    /// - Returns: A `NSCollectionLayoutSection` configured for categories.
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    /// Creates the layout section for products.
    ///
    /// - Returns: A `NSCollectionLayoutSection` configured for products.
    private func createProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // MARK: - UICollectionViewDataSource
    /// Returns the number of sections in the collection view.
    ///
    /// - Parameter collectionView: The collection view requesting this information.
    /// - Returns: The number of sections.
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return HomeSection.allCases.count
        }
    /// Returns the number of items in the specified section.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view requesting this information.
    ///   - section: The index of the section.
    /// - Returns: The number of items in the section.
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            guard let sectionType = HomeSection(rawValue: section) else { return 0 }
            switch sectionType {
            case .banners:
                return viewModel.banners.count
            case .categories:
                return viewModel.categories.count
            case .products:
                return viewModel.products.count
            }
        }
    /// Returns the cell for the specified item at the given index path.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view requesting this cell.
    ///   - indexPath: The index path of the item.
    /// - Returns: A configured `UICollectionViewCell` for the item.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            fatalError("Invalid section index: \(indexPath.section)")
        }
        
        switch section {
        case .banners:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath
            ) as? BannerCell else {
                fatalError("Could not dequeue BannerCell")
            }
            let banner = viewModel.banners[indexPath.item]
            cell.configure(with: banner.imageUrl)
            return cell
            
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier,
                for: indexPath
            ) as? CategoryCell else {
                fatalError("Could not dequeue CategoryCell")
            }
            let category = viewModel.categories[indexPath.item]
            cell.configure(with: category)
            return cell
            
        case .products:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCell.identifier,
                for: indexPath
            ) as? ProductCell else {
                fatalError("Could not dequeue ProductCell")
            }
            let product = viewModel.products[indexPath.item]
            cell.configure(with: product)
            return cell
        }
    }

}
