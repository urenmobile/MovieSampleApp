//
//  MovieDetailViewCoordinator.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/11/21.
//

import UIKit
import URENCore

final class MovieDetailViewCoordinator: BaseViewCoordinator<MovieDetailViewController, MovieDetailViewModel> {

    override func start() {
        super.start()
        sinkDismiss()
    }
    
    private func sinkDismiss() {
        viewModel.dismissSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.finish()
            }.cancel(by: cancelBag)
    }
    
}
