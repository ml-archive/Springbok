//
//  MoviesInteractor.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class MoviesInteractor {
    
    // MARK: - Properties -
    weak var output: MoviesInteractorOutput?
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension MoviesInteractor: MoviesInteractorInput {
    
    func perform(_ request: Movies.Request.FetchMovies) {
        dependencies
            .repository
            .getDiscoverMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Movies.Response.MoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Movies.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
}
