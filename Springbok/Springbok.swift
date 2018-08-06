//
//  Springbok.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public func request(_ url: URLConvertible,
                    method: HTTPMethod = .get,
                    parameters: Parameters? = nil,
                    headers: HTTPHeaders? = nil) -> Request {
    return SessionManager.shared.request(url, method: method, parameters: parameters, headers: headers)
}

public func cancelRequest(request: Request) {
    SessionManager.shared.cancelRequest(request: request)
}
