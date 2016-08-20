//
//  JoinVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/18/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class JoinVC: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    
    
    var ConnectionStatus = false
    
    
    override func viewDidAppear (animated : Bool) {
        if Handling.instance.connect() {
            ConnectionStatus = true
            self.title = "Connected"
        }
        else {
            self.title = "Disconnected"
            let alert = UIAlertController(title: "ERROR", message: "Cannot Connect To Server", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Retry", style: .Default, handler : retryConnecting)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func retryConnecting (alert : UIAlertAction!) {
        ConnectionStatus = Handling.instance.connect()
        if !ConnectionStatus {
            let alert = UIAlertController(title: "ERROR", message: "Cannot Connect To Server", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Retry", style: .Default, handler : retryConnecting)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
        else{
            self.title = "Connected"
        }
        
    }
    
    
    @IBAction func onJoinedTapped(sender: AnyObject) {
        if let name = nameTextfield.text {
            Player.instance.name = name
            Handling.instance.send(name)
        }
    }
   
   
}
