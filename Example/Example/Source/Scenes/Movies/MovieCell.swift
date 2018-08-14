//
//  MovieCell.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit
import Springbok

protocol MovieCellProtocol {
    func display(pictureURL: String)
}

final class MovieCell: UICollectionViewCell {
    
    // MARK: - Outlets -
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.contentMode = .scaleAspectFill
            pictureImageView.clipsToBounds = true
        }
    }
}

extension MovieCell: MovieCellProtocol {
    func display(pictureURL: String) {
        pictureImageView.setImage(url: pictureURL)
    }
}
