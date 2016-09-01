//
//  WaitingVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/21/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class WaitingVC: UIViewController , UITableViewDataSource {
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        Handling.instance.receive()
        Handling.instance.gameState = -1
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView:", name: "updateView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "roleVC:", name: "roleVC", object: nil)
        Player.instance.opponents.append(Player.instance.name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Player.instance.opponents.count
    }
    
    func updateView (notification: NSNotification) {
        tableView.reloadData()
        
    }
    
    func roleVC (notification : NSNotification) {
        performSegueWithIdentifier("roleVC", sender: nil)
    }
    
    
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
        // Configure the cell...
        cell.textLabel?.text = Player.instance.opponents[indexPath.row]
        
        return cell
    }

    @IBAction func onStartTapped (sender : AnyObject) {
        
    }


}
