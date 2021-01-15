//
//  MovieViewModel.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCore
import URENDomain
import URENCombine

final class MovieViewModel: BaseViewModel {
    
    private(set) var selectedMovieIdSubject = PassthroughSubject<Int, Never>()
    private(set) var styleSubject = PassthroughSubject<Style, Never>()
    private(set) var reloadableChangesSubject = PassthroughSubject<ReloadableChanges, Never>()
    
    var style = Style.list
    var loadingMore: Bool = false
    
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    private var items: [MovieModel] = []
    
    private let movieUseCase: MovieUseCase
    private let movieCoreDataController: MovieCoreDataControllerProvider
    
    init(movieUseCase: MovieUseCase, movieCoreDataController: MovieCoreDataControllerProvider) {
        self.movieUseCase = movieUseCase
        self.movieCoreDataController = movieCoreDataController
    }
    
    func refreshData() {
        currentPage = 1
        fetchAndLoadCoreData()
        getData()
    }
    
    private func getData(showLoading: Bool = true) {
        if showLoading {
            state.send(.loading)
        }
        
        let request = MovieRequest(page: currentPage, language: Constants.language)
        movieUseCase.execute(request).sink { [weak self] in
            switch $0 {
            case .success(let response):
                self?.handle(response: response)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func getNextData() {
        currentPage += 1
        getData(showLoading: false)
    }
    
    private func handle(response: MovieResponse) {
        if loadingMore, let results = response.results, !results.isEmpty {
            items.append(contentsOf: results)
            loadingMore = false
        }
        totalPages = response.totalPages ?? 1
        state.send(.populate)
    }
    
    func changeStyle() {
        style.changeStyle()
        styleSubject.send(style)
    }
    
    private func fetchAndLoadCoreData() {
        movieCoreDataController.reloadableChangesSubject.sink { [weak self] in
            self?.reloadableChangesSubject.send($0)
        }.cancel(by: cancelBag)
        
        movieCoreDataController.performFetch()
    }
    
    
    // MARK: - List Actions
    func numberOfSections() -> Int {
        return movieCoreDataController.numberOfSection()
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return movieCoreDataController.numberOfItemsInSection(section)
    }
    
    func item(at indexPath: IndexPath) -> ProductDetailViewData {
        let movieModel = movieCoreDataController.item(at: indexPath)
        
        var imageUrl: String?
        
        if let path = movieModel.backdropPath {
            imageUrl = Constants.getImageUrl(width: 400, path: path)
        }
        
        let viewData = ProductDetailViewData(title: movieModel.title,
                                             description: nil,
                                             detail: nil,
                                             imageUrl: imageUrl,
                                             isFavorite: movieModel.isFavorite ?? false,
                                             showFavorite: true)
        return viewData
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let movieModel = movieCoreDataController.item(at: indexPath)
        selectedMovieIdSubject.send(movieModel.id ?? 0)
    }
    
    func willDisplayItem(at indexPath: IndexPath) {
        // Decide to Pagination
        guard !loadingMore, currentPage < totalPages, indexPath.row == items.count - 2 else {
            return
        }
        
        loadingMore = true
        // fake loading animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.getNextData()
        }
    }
    
    func updateSearchResults(with text: String?) {
        movieCoreDataController.filter(with: text ?? "")
        movieCoreDataController.performFetch()
        state.send(.populate)
    }
}

// MARK: - Style
extension MovieViewModel {
    enum Style {
        case grid
        case list
        
        var iconName: String {
            switch self {
            case .grid:
                return Icon.list.name
            case .list:
                return Icon.grid.name
            }
        }
        
        mutating func changeStyle() {
            if self == .grid {
                self = .list
            } else {
                self = .grid
            }
        }
        
    }
}
