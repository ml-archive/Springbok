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
        XCTAssertEqual(request.request?.url?.absoluteString, "http://google.fr")
        XCTAssertEqual(request.method, HTTPMethod.get)
        XCTAssertEqual(request.request?.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
        XCTAssertEqual(request.request?.allHTTPHeaderFields?.count, 0)
        XCTAssertNil(request.unwrapper)
    }
    
    func testRequestWithWrongURL() {
        let request = Springbok.request("")
        
        XCTAssertNotNil(request.error)
        XCTAssertNil(request.url)
        XCTAssertNil(request.method)
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
        XCTAssertNil(request.request)
        XCTAssertNil(request.unwrapper)
    }
    
    func testRequestWithAnotherHTTPMethod() {
        let request = Springbok.request("http://google.fr", method: .post)
        
        XCTAssertEqual(request.method, HTTPMethod.post)
        XCTAssertEqual(request.request?.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testRequestWithParameters() {
        let request = Springbok.request("http://google.fr", method: .post, parameters: ["foo": "bar", "id": 1])
        
        // swiftlint:disable:next force_cast
        XCTAssertTrue(request.parameters!["foo"] as! String == "bar")
        
        // swiftlint:disable:next force_cast
        XCTAssertTrue(request.parameters!["id"] as! Int == 1)
    }
    
    func testRequestWithHeaders() {
        let request = Springbok.request(
            "http://google.fr",
            method: .post,
            parameters: nil,
            headers: ["Content-Type": "application/json"]
        )
        
        XCTAssert(request.headers!["Content-Type"] == "application/json")
        XCTAssertEqual(request.request?.allHTTPHeaderFields!.count, 1)
        XCTAssert(request.request?.allHTTPHeaderFields?["Content-Type"] == "application/json")
    }
    
    func testUrlEncoding() {
        let getRequest = Springbok.request("http://google.fr", method: .get, parameters: ["foo": "bar", "id": 1])
        XCTAssertEqual(getRequest.url?.absoluteString, "http://google.fr?id=1&foo=bar")
        XCTAssertEqual(getRequest.request?.url?.absoluteString, "http://google.fr?id=1&foo=bar")
        XCTAssertNil(getRequest.body)
        XCTAssertNil(getRequest.request?.httpBody)
        
        let postRequest = Springbok.request("http://google.fr", method: .post, parameters: ["foo": "bar", "id": 1])
        XCTAssertEqual(postRequest.url?.absoluteString, "http://google.fr")
        XCTAssertEqual(postRequest.request?.url?.absoluteString, "http://google.fr")
        XCTAssertEqual(postRequest.body, "{\"foo\":\"bar\",\"id\":1}".data(using: .utf8))
        XCTAssertEqual(postRequest.request?.httpBody, "{\"foo\":\"bar\",\"id\":1}".data(using: .utf8))
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
    
    func testRequestThreads() {
        let expect = expectation(description: "Completion must be in the main thread")
        Springbok
            .request("https://jsonplaceholder.typicode.com/users")
            .responseCodable { (_: Result<[User]>) in
                XCTAssertTrue(Thread.isMainThread)
                expect.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
    
    func testUnwrap() {
        let request = Springbok
            .request("https://api.deezer.com/user/5/playlists")
            .unwrap("data")
        XCTAssertNotNil(request.unwrapper)
        
        let expect = expectation(description: "Request should be unwrapped")
        request.responseCodable { (result: Result<[Playlist]>) in
            switch result {
            case .success(let playlists):
                XCTAssertEqual(playlists.count, 25)
                expect.fulfill()
            case .failure:
                XCTFail("Request should be unwrap")
            }
        }
        waitForExpectations(timeout: 5.0)
    }
}
