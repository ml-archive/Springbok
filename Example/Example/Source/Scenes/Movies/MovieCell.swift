//
//  MovieCell.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit
import Kingfisher

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
        if let url = URL(string: pictureURL) {
            pictureImageView.kf.setImage(with: url, options: [.processor(ReduceImageSizeProcessor())])
        }
    }
}
