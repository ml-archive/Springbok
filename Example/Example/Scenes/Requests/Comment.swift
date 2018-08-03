//
//  Comment.swift
//  Example
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

struct Comment: Codable {
    // swiftlint:disable:next identifier_name
    let id: Int
    let name: String
    let email: String
    let body: String
}
