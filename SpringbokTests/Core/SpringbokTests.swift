//
//  SpringbokTests.swift
//  SpringbokTests
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import XCTest
@testable import Springbok

class SpringbokTests: XCTestCase {
    
    func testRequestWithRightURL() {
        let request = Springbok.request("http://google.fr")
        
        XCTAssertNil(request.error)
        XCTAssertEqual(request.url?.absoluteString, "http://google.fr")
        XCTAssertEqual(request.method, HTTPMethod.get)
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }
    
    func testRequestWithWrongURL() {
        let request = Springbok.request("")
        
        XCTAssertNotNil(request.error)
        XCTAssertNil(request.url)
        XCTAssertNil(request.method)
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }
    
    func testRequestWithAnotherHTTPMethod() {
        let request = Springbok.request("http://google.fr", method: .post)
        
        XCTAssertEqual(request.method, HTTPMethod.post)
    }
    
    func testRequestWithParameters() {
        let request = Springbok.request("http://google.fr", method: .post, parameters: ["foo": "bar", "id": 1])
        
        // swiftlint:disable:next force_cast
        XCTAssert(request.parameters!["foo"] as! String == "bar")
        
        // swiftlint:disable:next force_cast
        XCTAssert(request.parameters!["id"] as! Int == 1)
    }
    
    func testRequestWithHeaders() {
        let request = Springbok.request(
            "http://google.fr",
            method: .post,
            parameters: nil,
            headers: ["Content-type": "application/json"]
        )
        
        XCTAssert(request.headers!["Content-type"] == "application/json")
    }
    
    func testUrlEncoding() {
        let getRequest = Springbok.request("http://google.fr", method: .get, parameters: ["foo": "bar", "id": 1])
        XCTAssertEqual(getRequest.url?.absoluteString, "http://google.fr?id=1&foo=bar")
        XCTAssertNil(getRequest.body)
        
        let postRequest = Springbok.request("http://google.fr", method: .post, parameters: ["foo": "bar", "id": 1])
        XCTAssertEqual(postRequest.url?.absoluteString, "http://google.fr")
        XCTAssertNotNil(postRequest.body)
        XCTAssertEqual(postRequest.body, "{\"foo\":\"bar\",\"id\":1}".data(using: .utf8))
    }
    
    func testGetResponse() {
        let expect = expectation(description: "Good request to retrieve all user")
        Springbok
            .request("https://jsonplaceholder.typicode.com/users")
            .responseCodable { (result: Result<[User]>) in
                switch result {
                case .success(let users):
                    XCTAssertEqual(users.count, 10)
                    expect.fulfill()
                case .failure:
                    XCTFail("User must be fetched")
                }
        }
        waitForExpectations(timeout: 5.0)
    }
}
