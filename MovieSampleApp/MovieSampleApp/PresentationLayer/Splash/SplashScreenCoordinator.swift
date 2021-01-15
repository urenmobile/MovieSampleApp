//
//  SplashScreenCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit
import URENCore

final class SplashScreenCoordinator: BaseViewCoordinator<SplashScreenViewController, SplashScreenViewModel> {
    
    override func start() {
        super.start()
        
        sinkDismiss()
        doSomething()
    }
    
    private func sinkDismiss() {
        viewModel.dismissSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.finish()
            }.cancel(by: cancelBag)
    }
    
    private func doSomething() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewModel.dismiss()
        }
    }
}
