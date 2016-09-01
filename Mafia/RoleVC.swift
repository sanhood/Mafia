//
//  RoleVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/21/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class RoleVC: UIViewController, UITableViewDataSource {
    @IBOutlet weak var roleLbl : UILabel!
    @IBOutlet var tableView:UITableView!
    var mafias : [String] = []
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        Handling.instance.gameState = 2
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Handling.instance.gameState = 0
        Handling.instance.receive()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateRoleLbl:", name: "setRole", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTable:", name: "mafias", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToDay:", name: "day", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRoleLbl (notification : NSNotification) {
        roleLbl.text = Handling.instance.receivedContent
        Player.instance.role = roleLbl.text!
        Handling.instance.gameState = 1
    }
    
    func goToDay (notification : NSNotification) {
        performSegueWithIdentifier("DayVC", sender: nil)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mafias.count
    }
    
    func updateTable (notification: NSNotification) {
        mafias.append(Handling.instance.receivedContent)
        tableView.reloadData()
        
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
        // Configure the cell...
        cell.textLabel?.text = mafias[indexPath.row]
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
