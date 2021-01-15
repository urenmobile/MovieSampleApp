//
//  MovieDetailViewController.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/11/21.
//

import UIKit
import URENCore
import URENCombine

final class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
    
    // MARK: - Variables
    
    private var productDetailView: ProductDetailView!
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(named: Icon.star.name), style: .plain, target: self, action: #selector(changeFavorite))
        return barButton
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    override func setupView() {
        title = Localizer.contentDetails.localized
        navigationItem.rightBarButtonItem = rightBarButton
        
        view.backgroundColor = .white
        productDetailView = ProductDetailView()
        productDetailView.isHidden = true
        productDetailView.applyTheme()
        
        view.addSubview(productDetailView)
        productDetailView.layout {
            $0.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            $0.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            $0.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        }
    }
    
    override func setupViewModel() {
        viewModel.state.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let `self` = self else { return }
            self.handle(state: $0)
        }.cancel(by: cancelBag)
        
        viewModel.detailSubject.receive(on: DispatchQueue.main).sink { [weak self] in
            self?.productDetailView.isHidden = false
            self?.productDetailView.configure(with: $0)
            self?.rightBarButton.image = UIImage(named: $0.isFavorite ? Icon.starFilled.name : Icon.star.name)
        }.cancel(by: cancelBag)
        
        viewModel.getData()
    }
    
    private func handle(state: State) {
        switch state {
        case .loading:
            showLoadingView()
        case .populate, .empty:
            removeLoadingView()
        case .failure(let alert):
            removeLoadingView()
            show(alert: alert)
        }
    }
    
    @objc
    private func changeFavorite() {
        viewModel.addOrRemoveFavorite()
    }
}
