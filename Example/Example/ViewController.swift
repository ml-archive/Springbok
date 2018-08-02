//
//  ViewController.swift
//  Example
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit
import Springbok

class ViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.rowHeight = 200
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageViewCell.reuseIdentifier)", for: indexPath)
            as? ImageViewCell else { return UITableViewCell() }
        
        cell.backgroundImageView.setImage(url: "https://picsum.photos/20\(indexPath.row)")
        
        return cell
    }

}
