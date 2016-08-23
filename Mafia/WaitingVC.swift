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
    @IBOutlet var startBtn: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        startBtn.enabled = false
        Handling.instance.receive()
        Handling.instance.gameState = -1
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView:", name: "updateView", object: nil)
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
        if Player.instance.opponents.count == 3 {
            startBtn.enabled = true
            Handling.instance.gameState = 0
            performSegueWithIdentifier("roleVC", sender: nil)
        }
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
