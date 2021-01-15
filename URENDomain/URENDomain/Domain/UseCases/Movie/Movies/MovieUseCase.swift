//
//  MovieUseCase.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCombine

public class MovieUseCase: BaseUseCase<MovieRequest, MovieResponse> {
    
    private let repository: MovieRepositoryProvider
    
    public init(repository: MovieRepositoryProvider) {
        self.repository = repository
    }
    
    public override func execute(_ input: MovieRequest) -> Future<MovieResponse, Error> {
        return repository.getMovies(request: input)
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
