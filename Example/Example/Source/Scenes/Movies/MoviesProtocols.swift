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
    // func perform(_ request: Movies.Request.Work)
}

// INTERACTOR -> PRESENTER (indirect)
protocol MoviesInteractorOutput: class {
    // func present(_ response: Movies.Response.Work)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol MoviesPresenterInput {
    func viewCreated()
}

// PRESENTER -> VIEW
protocol MoviesPresenterOutput: class {
    // func display(_ displayModel: Movies.DisplayData.Work)
}
