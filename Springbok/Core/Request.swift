//
//  Request.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

public class Request {

    // MARK: - Properties -
    public let error: Error?
    private(set) var url: URL?
    public let method: HTTPMethod?
    public let parameters: Parameters?
    public let headers: HTTPHeaders?
    private(set) var body: Data?
    private(set) var request: URLRequest?
    
    // MARK: - Lifecycle -
    init(url: URL, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        error = nil
        body = nil
        request = nil
        
        if parameters != nil {
            encodeRequest(with: method, parameters: parameters!)
        }
    }
    
    init(error: Error) {
        self.error = error
        url = nil
        method = nil
        parameters = nil
        headers = nil
        body = nil
        request = nil
    }
    
    // MARK: - Methods -
    private func encodeRequest(with method: HTTPMethod, parameters: Parameters) {
        guard let url = url else { return }
        
        if method == .get {
            self.url = URL(string: "\(url.absoluteString)?\(generateQuery(parameters: parameters))")!
        } else {
            body = generateBody(parameters: parameters)
        }
    }
    
    private func generateQuery(parameters: Parameters) -> String {
        var queryString = ""
        parameters
            .sorted {
                return $0.0 > $1.0
            }
            .forEach { item in
            queryString += "\(item.key)=\(item.value)&"
        }
        if queryString.last != nil { queryString.removeLast() }
        
        return queryString
    }
    
    private func generateBody(parameters: Parameters) -> Data? {
        if JSONSerialization.isValidJSONObject(parameters) {
            do {
                return try JSONSerialization.data(
                    withJSONObject: parameters,
                    options: [.sortedKeys]
                )
            } catch {
                return nil
            }
        }
        return nil
    }
}
