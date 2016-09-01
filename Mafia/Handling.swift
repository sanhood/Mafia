//
//  Handling.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/18/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import Foundation
//singleton to handle client's funcs
class Handling {
    static let instance = Handling()
    private let client : TCPClient!
    private var _receivedContent : String = ""
    private var _gameState : Int = -2
    var gameState : Int {
        get {
            return _gameState
        }
        
        set {
            _gameState = newValue
        }
    }

    var receivedContent : String {
        get {
            return _receivedContent
        }
        
        set {
            _receivedContent = newValue
        }
    }
    init(){
        client = TCPClient(addr: "192.168.1.105", port: 8080)
    }
    
    func send (d : String) {
        
        client.send(data :convertToUInt8(d))
    }
    
//receives continuously from server in a thread and handles the receivced data in main thread
    func receive ()  {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
         dispatch_async(queue) {
            while true{
            if let receivedContent = Handling.instance.client.read(1024*10) {
                print(self.convertToString(receivedContent))
                if self.convertToString(receivedContent) == "eliminated" {
                    dispatch_async(dispatch_get_main_queue()) {
                NSNotificationCenter.defaultCenter().postNotificationName("eliminated", object: nil)}
                }
                
                else if self.convertToString(receivedContent) == "rolevc" {
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("roleVC", object: nil)}
                }
                

                else if Handling.instance.gameState == -1 {
                    self.receivedContent = self.convertToString(receivedContent)
                    if !Player.instance.opponents.contains(self.receivedContent){
                        Player.instance.opponents.append(self.receivedContent)}
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("updateView", object: nil)}
               }
                    
                    else if Handling.instance.gameState == 0 {
                    self.receivedContent = self.convertToString(receivedContent)
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("setRole", object: nil)}
                    Handling.instance.gameState = 1
                }
                    
                
                
                else if self.convertToString(receivedContent) == "day" {
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("day", object: nil)}
                    Handling.instance.gameState == 2
                    
                }
                
                else if self.convertToString(receivedContent) == "night" {
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("night", object: nil)}
                    Handling.instance.gameState == 5
                    
                }
                else if self.convertToString(receivedContent) == "result" {
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("resultVC", object: nil)}
                }
                else if Handling.instance.gameState == 1 && Player.instance.role == "mafia"{
                    self.receivedContent = self.convertToString(receivedContent)
                    dispatch_async(dispatch_get_main_queue()) {
                        NSNotificationCenter.defaultCenter().postNotificationName("mafias", object: nil)}
                }
                
                else if self.convertToString(receivedContent).containsString("vote") {
                    self.receivedContent = (self.convertToString(receivedContent)).stringByReplacingOccurrencesOfString("vote", withString: "")
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("label", object: nil)
                        }
                    
                }
                else if Handling.instance.gameState == 3 {
                    self.receivedContent = self.convertToString(receivedContent)
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("table", object: nil)}
                }
                
                
                
                else if Handling.instance.gameState == 4 {
                    self.receivedContent = self.convertToString(receivedContent)
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotificationName("result", object: nil)}
                }
                
                
                
                
                
                
               
        

                }}
        }
        
}
    
    
//connects to server
    func connect () -> Bool {
        let (success,_) = client.connect(timeout: 1)
        return success
    }
    
//converts any object to [UInt8]
    func convertToUInt8 (d : AnyObject) -> [UInt8] {
        if d is String {
            let array: [UInt8] = Array((d as! String).utf8)
            return array
        }
        else {
            let myNSData = NSKeyedArchiver.archivedDataWithRootObject(d)
            let length = myNSData.length
            let myArray = [UInt8](count: length, repeatedValue: 0)
            return myArray
        }
    }
    
    func convertToString(d : [UInt8]) -> String {
        return String(bytes: d, encoding: NSUTF8StringEncoding)!
    }
    
}