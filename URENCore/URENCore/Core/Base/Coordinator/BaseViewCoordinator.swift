//
//  BaseViewCoordinator.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit

open class BaseViewCoordinator<InputViewController, InputViewModel>: BaseCoordinator<InputViewModel> where InputViewController: BaseViewController<InputViewModel>, InputViewModel: ViewModel {
    
    public var viewController: InputViewController!
    public var navigationController: BaseNavigationController!
    
    open override func start() {
        super.start()
        viewController = InputViewController()
        viewController.viewModel = viewModel
    }
    
    public func routeToBack(animated: Bool) {
        self.viewController.navigationController?.popViewController(animated: animated)
    }

    public func routeToRoot(animated: Bool) {
        self.viewController.navigationController?.popToRootViewController(animated: animated)
    }

    public func route(to viewController: UIViewController, animated: Bool) {
        self.viewController.show(viewController, sender: nil)
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.viewController.present(viewController, animated: animated, completion: completion)
    }
}
