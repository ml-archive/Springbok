//
//  UIViewController+Alert.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertError(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
