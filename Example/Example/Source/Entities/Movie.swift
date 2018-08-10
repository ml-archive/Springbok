//
//  Movie.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

struct Movie {
    let pictureURL: String
    
    var smallPictureUrl: String {
        return "https://image.tmdb.org/t/p/w500\(pictureURL)"
    }
    
    // MARK: - Lifecycle -
    init(dict: [String: Any]) {
        self.pictureURL = dict["poster_path"] as? String ?? ""
    }
}
