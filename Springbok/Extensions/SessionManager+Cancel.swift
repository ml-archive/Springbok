//
//  SessionManager+Cancel.swift
//  Springbok
//
//  Created by Maxime Maheo on 03/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

extension SessionManager {

    public func cancelRequests() {
        for request in requests {
            request.value.cancel()
        }
        requests.removeAll()
    }
    
    public func cancelRequest(request: Request) {
        if let url = request.getUrl()?.absoluteString {
            request.cancel()
            requests.removeValue(forKey: url)
        }
    }
    
    func requestFinish(_ request: Request) {
        if let url = request.url?.absoluteString {
            requests.removeValue(forKey: url)
        }
    }
    
}
