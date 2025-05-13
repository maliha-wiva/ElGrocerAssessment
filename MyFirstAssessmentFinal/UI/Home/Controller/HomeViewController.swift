//
//  HomeViewController.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    private var timer: Timer?
    private var currentIndex = 0
    private var viewModel: HomeViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var collectionView: UICollectionView!

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        bindViewModel()
        viewModel.fetchData()
        startAutoScrolling()
    }
    private func startAutoScrolling() {
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.scrollToNextBanner()
            }
        }

        private func stopAutoScrolling() {
            timer?.invalidate()
            timer = nil
        }

        private func scrollToNextBanner() {
            guard !viewModel.banners.isEmpty else { return }
            currentIndex = (currentIndex + 1) % viewModel.banners.count
            let indexPath = IndexPath(item: currentIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

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

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

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

    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }

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
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return HomeSection.allCases.count
        }

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
