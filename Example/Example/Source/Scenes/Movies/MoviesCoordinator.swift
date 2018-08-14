//
//  MoviesCoordinator.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

class MoviesCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let navigationController: UINavigationController
    private let window: UIWindow

    // MARK: - Lifecycle -
    init(window: UIWindow) {
        self.window = window
        
        navigationController = UINavigationController()
        
        children = []
    }

    // MARK: - Methods -
    func start() {
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter(interactor: interactor, coordinator: self)
        let viewController = MoviesViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.setViewControllers([viewController], animated: false)
        
        window.updateRootViewController(with: navigationController)
    }
}

// PRESENTER -> COORDINATOR
extension MoviesCoordinator: MoviesCoordinatorInput {

}
