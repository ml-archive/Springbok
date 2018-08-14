//
//  Dependencies.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

typealias FullDependencies = HasRepository

final class Dependencies {
    
    // MARK: - Properties -
    public static var shared = Dependencies()
    
    private(set) var repository: Repository
    
    // MARK: - Lifecycle -
    private init() {
        repository = RemoteRepository()
    }
}

extension Dependencies: HasRepository { }
