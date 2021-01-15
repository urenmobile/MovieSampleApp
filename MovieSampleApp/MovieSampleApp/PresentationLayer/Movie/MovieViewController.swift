//
//  MovieViewController.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import UIKit
import CoreData
import URENCore

final class MovieViewController: BaseViewController<MovieViewModel> {
    // MARK: - Variables
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(named: viewModel.style.iconName), style: .done, target: self, action: #selector(changeViewStyle))
        return barButton
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        collectionView.register(LoadMoreReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadMoreReusableView.reuseIdentifier)
        return collectionView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self

        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.placeholder = Localizer.searchMovie.localized
        
        return searchController
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    override func setupView() {
        view.backgroundColor = .white
        
        title = Localizer.contents.localized
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        view.addSubview(collectionView)
        
        collectionView.layout {
            $0.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            $0.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            $0.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setupViewModel() {
        viewModel.state.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let `self` = self else { return }
            self.handle(state: $0)
        }.cancel(by: cancelBag)
        
        viewModel.reloadableChangesSubject.receive(on: DispatchQueue.main).sink { [weak self] in
            self?.batchUpdate(with: $0)
        }.cancel(by: cancelBag)
        
        viewModel.styleSubject.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.rightBarButton.image = UIImage(named: $0.iconName)
            self.collectionView.reloadData()
        }.cancel(by: cancelBag)
        
        viewModel.refreshData()
    }
    
    private func handle(state: State) {
        switch state {
        case .loading:
            showLoadingView()
        case .populate, .empty:
            removeLoadingView()
            collectionView.reloadData()
        case .failure(let alert):
            removeLoadingView()
            show(alert: alert)
        }
    }
    
    private func batchUpdate(with reloadable: ReloadableChanges) {
        collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.insertItems(at: reloadable.insertItems)
            self?.collectionView.deleteItems(at: reloadable.deleteItems)
            self?.collectionView.reloadItems(at: reloadable.reloadItems)
            reloadable.moveItems.forEach { self?.collectionView.moveItem(at: $0.from, to: $0.to) }
        }, completion: nil)
    }
    
    @objc
    private func changeViewStyle() {
        viewModel.changeStyle()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 2 * layout.minimumInteritemSpacing
        let sectionInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let contentWidth: CGFloat = collectionView.frame.width - interItemSpacing - sectionInset
        
        if viewModel.style == .grid {
            return CGSize(width: contentWidth / 2, height: 300)
        }
        
        return CGSize(width: contentWidth, height: 200)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewData = viewModel.item(at: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(with: viewData)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension MovieViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel.loadingMore {
            return .zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if isFooterView(kind),
           let footerLoadingView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadMoreReusableView.reuseIdentifier, for: indexPath) as? LoadMoreReusableView {
            
            return footerLoadingView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if isFooterView(elementKind) {
            let loadMoreView = view as? LoadMoreReusableView
            if viewModel.loadingMore {
                loadMoreView?.startAnimating()
            } else {
                loadMoreView?.stopAnimating()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if isFooterView(elementKind) {
            let loadMoreView = view as? LoadMoreReusableView
            loadMoreView?.stopAnimating()
        }
    }
    
    private func isFooterView(_ elementKind: String) -> Bool {
        return elementKind == UICollectionView.elementKindSectionFooter
    }
}

// MARK: - UISearchResultsUpdating
extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearchResults(with: searchController.searchBar.text)
    }
}
