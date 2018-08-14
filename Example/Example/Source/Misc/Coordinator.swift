//
//  Coordinator.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    // MARK: - Properties -
    var children: [Coordinator] { get set }
    
    // MARK: - Methods -
    func start()
}
