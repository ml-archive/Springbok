//
//  ImageViewCell.swift
//  Example
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//
import UIKit

final class ImageViewCell: UITableViewCell {
    
    // MARK: - Properties -
    public static let reuseIdentifier = "\(ImageViewCell.self)"
    
    // MARK: - Outlets -
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
        }
    }
    
    override func prepareForReuse() {
        backgroundImageView.cancelDownloadTask()
    }
    
}
