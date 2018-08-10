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
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension MoviesInteractor: MoviesInteractorInput {
}
