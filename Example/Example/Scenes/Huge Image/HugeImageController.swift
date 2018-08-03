//
//  HugeImage.swift
//  Example
//
//  Created by Maxime Maheo on 03/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit
import Springbok

class HugeImageController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var hugeImageImageView: UIImageView! {
        didSet {
            hugeImageImageView.contentMode = .scaleAspectFill
            hugeImageImageView.clipsToBounds = true
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hugeImageImageView
            .setImage(
                url: "https://eoimages.gsfc.nasa.gov/images/imagerecords/78000/78314/VIIRS_3Feb2012_lrg.jpg"
            )
    }
    
}
