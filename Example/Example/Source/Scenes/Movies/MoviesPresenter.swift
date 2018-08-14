//
//  MoviesPresenter.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class MoviesPresenter {
    
    // MARK: - Properties -
    let interactor: MoviesInteractorInput
    weak var coordinator: MoviesCoordinatorInput?
    weak var output: MoviesPresenterOutput?

    private var movies: [Movie]
    private var page: Int
    
    // MARK: - Lifecycle -
    init(interactor: MoviesInteractorInput, coordinator: MoviesCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        movies = []
        page = 1
    }
}

// MARK: - User Events -

extension MoviesPresenter: MoviesPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        return movies.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        interactor.perform(Movies.Request.FetchMovies(page: page))
    }
    
    func configure(item: MovieCellProtocol, at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        item.display(pictureURL: movie.smallPictureUrl)
    }
    
    func displayNext() {
        page += 1
        interactor.perform(Movies.Request.FetchMovies(page: page))
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension MoviesPresenter: MoviesInteractorOutput {
    func present(_ response: Movies.Response.MoviesFetched) {
        page == 1 ? movies = response.movies : movies.append(contentsOf: response.movies)
        
        output?.display(Movies.DisplayData.Movies())
    }
    
    func present(_ response: Movies.Response.Error) {
        output?.display(Movies.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
