//
//  URLConvertible.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//
import Foundation

public protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw SBError.invalidURL(url: self) }
        
        return url
    }
}

extension URLConvertible {
    public func asString() -> String {
        return "\(self)"
    }
}
