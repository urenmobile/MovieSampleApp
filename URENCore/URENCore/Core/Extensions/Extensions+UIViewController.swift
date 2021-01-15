//
//  Extensions+UIViewController.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit

extension UIViewController {
    /// An extension add child view controller and move parent
    /// - Returns: void
    public func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// An extension remove from parent view and viewcontroller
    /// - Returns: void
    public func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    /// An extension add child view controller to containerview
    /// - Returns: void
    public func add(child: UIViewController, to containerView: UIView) {
        /// view controller view to containerview
        addChild(child)
        child.view.frame = containerView.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
