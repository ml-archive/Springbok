//
//  SessionManager.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

class SessionManager {
    
    // MARK: - Properties -
    public static let `default`: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        return SessionManager(configuration: configuration)
    }()
    
    public let session: URLSession
    
    // MARK: - Lifecycle -
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: configuration)
    }
    
    // MARK: - Methods -
    public func request(_ url: URLConvertible,
                        method: HTTPMethod,
                        parameters: Parameters?,
                        headers: HTTPHeaders?) -> Request {
        do {
            return try Request(url: url.asURL(), method: method, parameters: parameters, headers: headers)
        } catch {
            return Request(error: error)
        }
    }
}
