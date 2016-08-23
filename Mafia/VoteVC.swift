//
//  VoteVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/22/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class VoteVC: UIViewController , UITableViewDataSource {
    @IBOutlet weak var playerLbl : UILabel!
    @IBOutlet weak var tableView : UITableView!
    
    var names : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Handling.instance.receive()
        Handling.instance.gameState = 2
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTable:", name: "table", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabel:", name: "label", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onVoteTapped (sender : AnyObject) {
        Handling.instance.send(Player.instance.name)
    }
    
    
    func updateLabel (notification : NSNotification) {
        playerLbl.text = Handling.instance.receivedContent
    }

    func updateTable (notification : NSNotification) {
        names.append(Handling.instance.receivedContent)
        tableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
        cell.textLabel?.text = names[indexPath.row]
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
