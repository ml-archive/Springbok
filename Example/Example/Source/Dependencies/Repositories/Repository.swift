//
//  Repository.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Alamofire

protocol HasRepository {
    
    // MARK: - Properties -
    var repository: Repository { get }
    
}

protocol Repository {
    
    func getDiscoverMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    
}
