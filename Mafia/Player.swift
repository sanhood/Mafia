//
//  Player.swift
//  TestServer
//
//  Created by Soroush Shahi on 8/17/16.
//  Copyright © 2016 Soroush. All rights reserved.
//

import Foundation
import Darwin.C

class Player {
    private let _client : TCPClient!
    private var role : String!
    
    private var client : TCPClient {
        get {
            return _client
        }
    }
    
    init (client: TCPClient) {
        _client = client
    }
}
