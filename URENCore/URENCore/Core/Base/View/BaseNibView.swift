//
//  BaseNibView.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit

open class BaseNibView: BaseView {
    // MARK: - Variables
    private var contentView: UIView!
    
    // MARK: - Life Cycle
    public override func setupView() {
        loadFromXIB()
    }
    
    private func loadFromXIB() {
        let name = String(describing: classForCoder)
        let view = Bundle(for: classForCoder).loadNibNamed(name, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        contentView = view
    }
}
