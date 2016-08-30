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
    private var _role : String!
    private let _name : String!
    private var _recievedContent: String! = ""
    private var _hasVoted = false
    private var _numberOfVotes = 0
    private var _isVoting = false
    
    var isVoting : Bool {
        get{
            return _isVoting
        }
        
        set {
            _isVoting = newValue
        }
    }
    
    var hasVoted : Bool {
        get{
            return _hasVoted
        }
        
        set {
            _hasVoted = newValue
        }
    }

    
    var numberOfVotes : Int {
        get{
            return _numberOfVotes
        }
        
        set {
            _numberOfVotes = newValue
        }
    }
    var client : TCPClient {
        get {
            return _client
        }
        
        
    }
    
    var recievedContent : String {
        get {
            return _recievedContent
        }
        
        set {
            _recievedContent = newValue
        }
    }
    
    var role : String {
        get {
            return _role
        }
        set {
            _role = newValue
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
    
    func recieve () {
        let GlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(GlobalQueue){
            while tof {
            if let recievedContent = self.client.read(1024*10) {
                self.recievedContent = self.convertToString(recievedContent)
               // print(self.recievedContent)
                sendToAll(self.recievedContent)
                for player in players {
                    if player.isVoting == true {
                            player.numberOfVotes++
                    }
                }

            }
            
        }
    }
    }
    
    func read () -> String {
        return convertToString(client.read(1024*10)!)
    }
    
    func convertToString(d : [UInt8]) -> String {
        return String(bytes: d, encoding: NSUTF8StringEncoding)!
    }
}
