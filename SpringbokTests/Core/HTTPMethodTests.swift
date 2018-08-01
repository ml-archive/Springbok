//
//  HTTPMethodTests.swift
//  SpringbokTests
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import XCTest
@testable import Springbok

class HTTPMethodTests: XCTestCase {
    
    func testAllMethods() {
        XCTAssert(HTTPMethod.get.rawValue == "GET")
        XCTAssert(HTTPMethod.post.rawValue == "POST")
        XCTAssert(HTTPMethod.patch.rawValue == "PATCH")
        XCTAssert(HTTPMethod.put.rawValue == "PUT")
        XCTAssert(HTTPMethod.delete.rawValue == "DELETE")
    }
    
}
