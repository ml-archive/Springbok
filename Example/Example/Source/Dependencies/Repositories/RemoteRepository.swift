//
//  RemoteRepository.swift
//  Example
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Alamofire

final class RemoteRepository {
    
    // MARK: - Properties -
    private let baseURL: String
    private var defaultParameters: Parameters

    // MARK: - Lifecycle -
    init() {
        baseURL = "https://api.themoviedb.org/3"
        defaultParameters = [:]
        defaultParameters["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
        defaultParameters["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
    }
}

extension RemoteRepository: Repository {
    
    func getDiscoverMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/discover/movie", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    if (response.error! as NSError).code == NSURLErrorCancelled { return }
                    return completion(.failure(response.error!))
                }
                
                guard
                    let json = response.result.value as? [String: Any],
                    let results = json["results"] as? [[String: Any]]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                let movies = results.compactMap { dict in
                    return Movie(dict: dict)
                }
                
                return completion(.success(movies))
        }
    }
    
}
