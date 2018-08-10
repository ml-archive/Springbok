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

    // MARK: - Lifecycle -
    init(interactor: MoviesInteractorInput, coordinator: MoviesCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension MoviesPresenter: MoviesPresenterInput {
    func viewCreated() {

    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension MoviesPresenter: MoviesInteractorOutput {

}
