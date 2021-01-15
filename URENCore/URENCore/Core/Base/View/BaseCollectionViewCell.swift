//
//  BaseCollectionViewCell.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    
    public var contentStackView: UIStackView!
    
    // MARK: - Life Cycles
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    open func setupView() {
        contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        }
    }
}
