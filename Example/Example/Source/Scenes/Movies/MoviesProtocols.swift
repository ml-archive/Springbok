//
//  MoviesProtocols.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol MoviesCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol MoviesCoordinatorInput: class {

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol MoviesInteractorInput {
    func perform(_ request: Movies.Request.FetchMovies)
}

// INTERACTOR -> PRESENTER (indirect)
protocol MoviesInteractorOutput: class {
    func present(_ response: Movies.Response.MoviesFetched)
    
    func present(_ response: Movies.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol MoviesPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func configure(item: MovieCellProtocol, at indexPath: IndexPath)
    func displayNext()
}

// PRESENTER -> VIEW
protocol MoviesPresenterOutput: class {
    func display(_ displayModel: Movies.DisplayData.Movies)
    
    func display(_ displayModel: Movies.DisplayData.Error)
}
