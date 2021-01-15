//
//  MovieAddFavoriteUseCase.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/13/21.
//

import Foundation
import URENCombine

public class MovieAddFavoriteUseCase: BaseUseCase<MovieAddFavoriteRequest, MovieAddFavoriteResponse> {
    
    private let repository: MovieRepositoryProvider
    
    public init(repository: MovieRepositoryProvider) {
        self.repository = repository
    }
    
    public override func execute(_ input: MovieAddFavoriteRequest) -> Future<MovieAddFavoriteResponse, Error> {
        return repository.addFavorite(request: input)
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
