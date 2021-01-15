//
//  MovieRemoveFavoriteUseCase.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/13/21.
//

import Foundation
import URENCombine

public class MovieRemoveFavoriteUseCase: BaseUseCase<MovieRemoveFavoriteRequest, MovieRemoveFavoriteResponse> {
    
    private let repository: MovieRepositoryProvider
    
    public init(repository: MovieRepositoryProvider) {
        self.repository = repository
    }
    
    public override func execute(_ input: MovieRemoveFavoriteRequest) -> Future<MovieRemoveFavoriteResponse, Error> {
        return repository.removeFavorite(request: input)
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
