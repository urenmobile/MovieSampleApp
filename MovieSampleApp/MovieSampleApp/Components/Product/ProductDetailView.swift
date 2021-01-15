//
//  ProductDetailView.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit
import URENCore

class ProductDetailView: BaseView {
    
    private var contentStackView: UIStackView!
    private var imageViewHeightConstraint: NSLayoutConstraint!
    
    private let padding: CGFloat = 16

    private let imageView: URENImageView = {
        let imageView = URENImageView()
        return imageView
    }()
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.image = UIImage(named: Icon.star.name)
        imageView.isHidden = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 2
        imageView.layer.shadowOpacity = 0.2
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Title]"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "[Description]"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "[Detail]"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        return label
    }()
    
    override func setupView() {
        super.setupView()
        
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, detailLabel])
        titleStackView.axis = .vertical
        titleStackView.spacing = padding
        titleStackView.isLayoutMarginsRelativeArrangement = true
        titleStackView.layoutMargins = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        
        contentStackView = UIStackView(arrangedSubviews: [imageView, titleStackView, spacerView])
        contentStackView.axis = .vertical
        contentStackView.spacing = padding
        
        addSubview(contentStackView)
        addSubview(favoriteImageView)
        
        contentStackView.layout {
            $0.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            $0.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            $0.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            $0.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            imageView.widthAnchor.constraint(equalTo: $0.widthAnchor)
        }
        
        layout {
            favoriteImageView.topAnchor.constraint(equalTo: $0.topAnchor, constant: padding/2)
            favoriteImageView.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -padding/2)
        }
    }
    
}

extension ProductDetailView: Configurable {
    
    func configure(with viewModel: ProductDetailViewData) {
        favoriteImageView.image = UIImage(named: viewModel.isFavorite ? Icon.starFilled.name : Icon.star.name)
        favoriteImageView.isHidden = !viewModel.showFavorite
        titleLabel.text = viewModel.title
        titleLabel.isHidden = viewModel.title == nil
        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description == nil
        detailLabel.text = viewModel.detail
        detailLabel.isHidden = viewModel.detail == nil
        if let imageUrl = viewModel.imageUrl, let url = URL(string: imageUrl) {
            imageView.loadImageFrom(url: url)
        }
    }
    
    func applyTheme() {
        titleLabel.textColor = .black
    }
}
