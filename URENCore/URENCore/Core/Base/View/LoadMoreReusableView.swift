//
//  LoadMoreReusableView.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 1/15/21.
//

import UIKit

public class LoadMoreReusableView: UICollectionReusableView, ReuseIdentifying {
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(activityIndicatorView)
        
        activityIndicatorView.layout {
            $0.safeCenterXAnchor.constraint(equalTo: safeCenterXAnchor)
            $0.safeCenterYAnchor.constraint(equalTo: safeCenterYAnchor)
        }
    }
    
    public func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    public func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
