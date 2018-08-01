//
//  URLConvertibleTests.swift
//  SpringbokTests
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import XCTest
@testable import Springbok

class URLConvertibleTests: XCTestCase {
    
    func testConvertStringToURL() {
        XCTAssertThrowsError(try "".asURL())
        XCTAssertNoThrow(try "http://google.fr".asURL())
    }
    
}
