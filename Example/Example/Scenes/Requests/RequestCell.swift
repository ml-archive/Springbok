//
//  RequestCell.swift
//  Example
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit
import Springbok

final class RequestCell: UITableViewCell {
    
    // MARK: - Properties -
    public static let reuseIdentifier = "\(RequestCell.self)"
    
    // MARK: - Outlets -
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Methods -
    public func configure(indexPath: IndexPath) {
        Springbok
            .request("https://jsonplaceholder.typicode.com/comments/\(indexPath.row + 1)")
            .responseCodable { (result: Result<Comment>) in
                if case let .success(comment) = result {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.idLabel.text = "\(comment.id)"
                        self.nameLabel.text = comment.name
                        self.emailLabel.text = comment.email
                        self.bodyLabel.text = comment.body
                    })
                }
        }
    }
}
