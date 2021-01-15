//
//  SplashScreenViewController.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit
import URENCore

final class SplashScreenViewController: BaseViewController<SplashScreenViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showLoadingView()
    }
}
