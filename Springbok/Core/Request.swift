//
//  Request.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

public class Request {

    // MARK: - Properties -
    let error: Error?
    private(set) var url: URL?
    let method: HTTPMethod?
    let parameters: Parameters?
    let headers: HTTPHeaders?
    private(set) var body: Data?
    private(set) var request: URLRequest?
    private(set) var unwrapper: String?
    var task: URLSessionDataTask?
    
    // MARK: - Lifecycle -
    init(url: URL, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        error = nil
        body = nil
        request = nil
        task = nil
        
        if parameters != nil {
            encodeRequestParameters()
        }
        
        createRequest()
    }
    
    init(error: Error) {
        self.error = error
        url = nil
        method = nil
        parameters = nil
        headers = nil
        body = nil
        request = nil
        task = nil
    }
    
    // MARK: - Methods -
    private func createRequest() {
        request = URLRequest(url: url!)
        request?.httpMethod = method?.rawValue
        request?.allHTTPHeaderFields = headers
        
        if isRequestNeedBody() {
            request?.httpBody = body
        }
    }
    
    private func isRequestNeedBody() -> Bool {
        return method != .get
    }
    
    private func isRequestNeedParametersURL() -> Bool {
        return method == .get
    }
    
    private func encodeRequestParameters() {
        guard let url = url else { return }
        
        if isRequestNeedParametersURL() {
            self.url = URL(string: "\(url.absoluteString)?\(generateQuery())")!
        } else {
            body = generateBody()
        }
    }
    
    private func generateQuery() -> String {
        guard let parameters = parameters else { return "" }
        
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
    
    private func generateBody() -> Data? {
        guard let parameters = parameters else { return nil }
        
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
    
    public func unwrap(_ unwrapper: String) -> Request {
        self.unwrapper = unwrapper
        
        return self
    }
    
    func cancel() {
        task?.cancel()
    }
}
