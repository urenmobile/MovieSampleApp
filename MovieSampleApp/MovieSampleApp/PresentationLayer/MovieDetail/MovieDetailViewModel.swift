//
//  MovieDetailViewModel.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCore
import URENDomain
import URENCombine

final class MovieDetailViewModel: BaseViewModel {
    
    private var movie: MovieModel?
    
    private(set) var detailSubject = PassthroughSubject<ProductDetailViewData, Never>()
    
    private let movieId: Int
    private let movieDetailUseCase: MovieDetailUseCase
    private let movieAddFavoriteUseCase: MovieAddFavoriteUseCase
    private let movieRemoveFavoriteUseCase: MovieRemoveFavoriteUseCase

    init(movieId: Int,
         movieDetailUseCase: MovieDetailUseCase,
         movieAddFavoriteUseCase: MovieAddFavoriteUseCase,
         movieRemoveFavoriteUseCase: MovieRemoveFavoriteUseCase) {
        self.movieId = movieId
        self.movieDetailUseCase = movieDetailUseCase
        self.movieAddFavoriteUseCase = movieAddFavoriteUseCase
        self.movieRemoveFavoriteUseCase = movieRemoveFavoriteUseCase
    }
    
    func getData() {
        state.send(.loading)
        
        let request = MovieDetailRequest(id: movieId, language: Constants.language)
        movieDetailUseCase.execute(request).sink { [weak self] in
            switch $0 {
            case .success(let response):
                self?.handle(response: response)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func handle(response: MovieModel) {
        state.send(.populate)
        movie = response
        
        let detail = String(format: Localizer.voteCountFormatted.localized, response.voteCount ?? 0)
        
        var imageUrl: String?
        
        if let path = response.posterPath {
            imageUrl = Constants.getImageUrl(width: 500, path: path)
        }
        
        
        let viewData = ProductDetailViewData(title: response.title,
                                             description: response.overview,
                                             detail: detail,
                                             imageUrl: imageUrl,
                                             isFavorite: response.isFavorite ?? false)
        detailSubject.send(viewData)
    }
    
    func addOrRemoveFavorite() {
        guard let movie = movie else {
            return
        }
        
        let isFavorite = movie.isFavorite ?? false
        if isFavorite {
            removeFavorite(movie: movie)
        } else {
            addFavorite(movie: movie)
        }
    }
    
    private func addFavorite(movie: MovieModel) {
        movie.isFavorite = true
        
        let request = MovieAddFavoriteRequest(movie: movie)
        
        switch movieAddFavoriteUseCase.execute(request).result! {
        case .success(let response):
            handle(response: response.movie)
        case .failure(let error):
            handle(error: error)
        }
    }
    
    private func removeFavorite(movie: MovieModel) {
        movie.isFavorite = false
        
        let request = MovieRemoveFavoriteRequest(movie: movie)
        
        switch movieRemoveFavoriteUseCase.execute(request).result! {
        case .success(let response):
            handle(response: response.movie)
        case .failure(let error):
            handle(error: error)
        }
    }
    
}
