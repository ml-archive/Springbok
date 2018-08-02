//
//  SessionManager.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//
import UIKit

class SessionManager {
    
    // MARK: - Properties -
    public static let `default`: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        return SessionManager(configuration: configuration)
    }()
    
    public let session: URLSession
    public var downloadImageTasks: [String: URLSessionDataTask]
    public var imageCache: NSCache<NSString, UIImage>
    
    // MARK: - Lifecycle -
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: configuration)
        downloadImageTasks = [:]
        imageCache = NSCache()
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
