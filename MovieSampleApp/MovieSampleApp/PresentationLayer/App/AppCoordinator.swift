//
//  AppCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import UIKit
import URENCore
import URENDomain
import URENData
import URENCombine
import URENCoreData

final class AppCoordinator: BaseCoordinator<AppViewModel> {
    
    private let networkReachability: NetworkReachabilityManager
    private let window = UIWindow(frame: UIScreen.main.bounds)
    
    public init(networkReachability: NetworkReachabilityManager, appViewModel: AppViewModel) {
        self.networkReachability = networkReachability
        super.init(viewModel: appViewModel)
    }
    
    override func start() {
        super.start()
        showSplash()
    }
    
    private func showSplash() {
        let viewModel = SplashScreenViewModel()
        let coordinator = SplashScreenCoordinator(viewModel: viewModel)
        start(coordinator: coordinator)
        
        coordinator.didFinishSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showMovie()
            }.cancel(by: cancelBag)
        
        window.setRootViewController(coordinator.viewController, animated: true)
    }
    
    private func showMovie() {
        removeChildCoordinators()
        
        // Dependency Configuration
        let httpClient: HttpClientProvider = HttpClient.shared 
        let service: MovieServiceProvider = MovieService()
        
        let remote: MovieRemoteProvider = MovieRemote(httpClient: httpClient, service: service)
        
        let coreDataManager: CoreDataManager = CoreDataManager.shared
        let localRepository: MovieCoreDataRepository = MovieCoreDataRepository(persistentContainer: coreDataManager.persistentContainer)
        
        let local: MovieLocalRepositoryProvider = MovieLocalRepository(repository: localRepository)
        let repository: MovieRepositoryProvider = MovieRepository(remote: remote, local: local)
        let useCase = MovieUseCase(repository: repository)
        
        let movieCoreDataController: MovieCoreDataControllerProvider = MovieCoreDataController()
        
        let viewModel = MovieViewModel(movieUseCase: useCase, movieCoreDataController: movieCoreDataController)

        // Start Coordinator
        let coordinator = MovieViewCoordinator(viewModel: viewModel)
        start(coordinator: coordinator)
        
        window.setRootViewController(coordinator.navigationController, animated: true)
        
        sinkNetworkReachability()
    }
    
    private func sinkNetworkReachability() {
        networkReachability.statusSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showNetworkErrorIfNeeded(with: $0)
            }.cancel(by: cancelBag)
        
        networkReachability.start()
    }
    
    private func showNetworkErrorIfNeeded(with status: NetworkReachabilityManager.Status) {
        if case .notReachable = status {
            let okAction = AlertAction(title: Localizer.ok.localized)
            let alert = AnyAlert(title: Localizer.error.localized, message: Localizer.noInternetConnection.localized, style: .alert, actions: [okAction])
            UIApplication.topViewController()?.show(alert: alert)
        }
    }
    
}
