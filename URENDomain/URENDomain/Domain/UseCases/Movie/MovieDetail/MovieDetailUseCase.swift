//
//  MovieDetailUseCase.swift
//  URENDomain
//
//  Created by Remzi YILDIRIM on 1/10/21.
//

import Foundation
import URENCombine

public class MovieDetailUseCase: BaseUseCase<MovieDetailRequest, MovieDetailResponse> {
    
    private let repository: MovieRepositoryProvider
    
    public init(repository: MovieRepositoryProvider) {
        self.repository = repository
    }
    
    public override func execute(_ input: MovieDetailRequest) -> Future<MovieDetailResponse, Error> {
        return repository.getMovieDetail(request: input)
    }
    
    deinit {
        debugPrint("**** deinit \(String(describing: self))")
    }
}
