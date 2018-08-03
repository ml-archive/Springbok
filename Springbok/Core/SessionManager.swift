//
//  SessionManager.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

class SessionManager {
    
    // MARK: - Properties -
    public static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        return SessionManager(configuration: configuration)
    }()
    
    public let session: URLSession
    public var requests: [String: Request]
    
    // MARK: - Lifecycle -
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: configuration)
        requests = [:]
    }
    
    // MARK: - Methods -
    public func request(_ url: URLConvertible,
                        method: HTTPMethod,
                        parameters: Parameters?,
                        headers: HTTPHeaders?) -> Request {
        do {
            let request = try Request(url: url.asURL(), method: method, parameters: parameters, headers: headers)
            requests[url.asString()] = request
            
            return request
        } catch {
            return Request(error: error)
        }
    }
}
