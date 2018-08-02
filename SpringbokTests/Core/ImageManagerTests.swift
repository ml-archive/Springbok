//
//  ImageManagerTests.swift
//  SpringbokTests
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import XCTest
import UIKit
@testable import Springbok

class ImageManagerTests: XCTestCase {
    
    func testGetImage() {
        let existsPredicate = NSPredicate(format: "image != nil")
        
        let imageView = UIImageView()
        imageView.setImage(url: "https://picsum.photos/2000")
        
        expectation(for: existsPredicate, evaluatedWith: imageView, handler: nil)
        
        waitForExpectations(timeout: 5.0)
    }
    
}
