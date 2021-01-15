//
//  MovieViewCoordinator.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import UIKit
import URENCore
import URENDomain
import URENData
import URENCoreData

final class MovieViewCoordinator: BaseViewCoordinator<MovieViewController, MovieViewModel> {

    override func start() {
        super.start()
        navigationController = BaseNavigationController(rootViewController: viewController)
        sinkSelectedMovie()
    }
    
    private func sinkSelectedMovie() {
        viewModel.selectedMovieIdSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showDetail(with: $0)
            }.cancel(by: cancelBag)
    }
    
    private func showDetail(with movieId: Int) {
        
        // Dependency Configuration
        let httpClient: HttpClientProvider = HttpClient.shared
        let service: MovieServiceProvider = MovieService()
        
        let remote: MovieRemoteProvider = MovieRemote(httpClient: httpClient, service: service)
        
        let coreDataManager: CoreDataManager = CoreDataManager.shared
        let localRepository: MovieCoreDataRepository = MovieCoreDataRepository(persistentContainer: coreDataManager.persistentContainer)
        let local: MovieLocalRepositoryProvider = MovieLocalRepository(repository: localRepository)
        
        
        let repository: MovieRepositoryProvider = MovieRepository(remote: remote, local: local)
        let useCase = MovieDetailUseCase(repository: repository)
        
        let movieAddFavoriteUseCase = MovieAddFavoriteUseCase(repository: repository)
        let movieRemoveFavoriteUseCase = MovieRemoveFavoriteUseCase(repository: repository)

        let viewModel = MovieDetailViewModel(movieId: movieId, movieDetailUseCase: useCase, movieAddFavoriteUseCase: movieAddFavoriteUseCase, movieRemoveFavoriteUseCase: movieRemoveFavoriteUseCase)

        // Start Coordinator
        let coordinator = MovieDetailViewCoordinator(viewModel: viewModel)
        start(coordinator: coordinator)
        
        route(to: coordinator.viewController, animated: true)
    }
}
