//
//  Player.swift
//  TestServer
//
//  Created by Soroush Shahi on 8/17/16.
//  Copyright © 2016 Soroush. All rights reserved.
//

import Foundation
import Darwin.C

//singleton to handle player
class Player {
    static let instance = Player(name: "")
    private var _name : String!
    private var _role : String = ""
    private var _opponents = [String]()
    var opponents : [String] {
        get {
            return _opponents
        }
        
        set{
            _opponents = newValue
        }
    }
    init(name : String){
        _name = name
    }
    
    var name : String {
        get {
            return _name
        }
        
        set{
            _name = newValue
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
    
}
