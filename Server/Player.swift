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
    private let _name : String!
    
    private var client : TCPClient {
        get {
            return _client
        }
    }
    
    init (client: TCPClient , name:[UInt8]) {
        _client = client
        _name = String(bytes: name, encoding: NSUTF8StringEncoding)!
    }
    
    var name : String {
        get {
            return _name
        }
    }
    
    func send (d : String) {
        client.send(str: d)
    }
    
    func read () -> String {
        return convertToString(client.read(1024*10)!)
    }
    
    func convertToString(d : [UInt8]) -> String {
        return String(bytes: d, encoding: NSUTF8StringEncoding)!
    }
}
