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
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .black
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 4
            layout.minimumInteritemSpacing = 4
            
            collectionView.collectionViewLayout = layout
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        
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

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath)
                as? MovieCell
            else { return UICollectionViewCell() }
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfItems - 10 {
            presenter.displayNext()
        }
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3 - 4
        
        return CGSize(width: width, height: width * 1.5)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension MoviesViewController: MoviesPresenterOutput {
    func display(_ displayModel: Movies.DisplayData.Movies) {
        collectionView.reloadData()
    }
    
    func display(_ displayModel: Movies.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
