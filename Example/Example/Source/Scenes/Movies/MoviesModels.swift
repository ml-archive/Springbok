//
//  MoviesModels.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

enum Movies {
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Movies.Request {
    struct FetchMovies { let page: Int }
}

extension Movies.Response {
    struct MoviesFetched { let movies: [Movie] }
    struct Error { let errorMessage: String }
}

extension Movies.DisplayData {
    struct Movies { }
    struct Error { let errorMessage: String }
}
