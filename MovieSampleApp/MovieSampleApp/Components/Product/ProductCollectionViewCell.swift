//
//  ProductCollectionViewCell.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit
import URENCore

class ProductCollectionViewCell: BaseCollectionViewCell {
    
    private var productDetailView: ProductDetailView!
    
    override func setupView() {
        super.setupView()
        
        productDetailView = ProductDetailView()
        contentStackView.addArrangedSubview(productDetailView)
        contentStackView.layoutIfNeeded()
        
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.2
        contentView.clipsToBounds = true
    }
}

// MARK: - Configurable
extension ProductCollectionViewCell: Configurable {
    
    func configure(with viewModel: ProductDetailViewData) {
        productDetailView.configure(with: viewModel)
    }
    
}
