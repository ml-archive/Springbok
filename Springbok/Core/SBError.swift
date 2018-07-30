//
//  SBError.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

public enum SBError: Error {
    case invalidURL(url: String)
    case invalidRequest
    case emptyData
}
