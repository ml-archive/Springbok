//
//  MoviesViewController.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: MoviesPresenterInput!

    // MARK: - Outlets -
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: MoviesPresenterInput) -> MoviesViewController {
        let name = "\(MoviesViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! MoviesViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Actions -
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension MoviesViewController: MoviesPresenterOutput {

}
