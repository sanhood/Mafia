//
//  VoteVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/22/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class DayVC: UIViewController , UITableViewDataSource {
    @IBOutlet weak var playerLbl : UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var voteBtn : UIButton!
    
    var names : [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteBtn.enabled = false
        Handling.instance.receive()
        Handling.instance.gameState = 2
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTable:", name: "table", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabel:", name: "label", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToResultVC:", name: "resultVC", object: nil)
        if Player.instance.isEliminated {
            voteBtn.enabled = false
        }
        tableView.dataSource = self
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        Handling.instance.gameState = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToResultVC (notification: NSNotification) {
        performSegueWithIdentifier("ResultVC", sender: nil)
    }
    
    
    
    @IBAction func onVoteTapped (sender : AnyObject) {
        
        Handling.instance.send("general"+Player.instance.name)
       // if voteBtn.currentTitle == "vote" {
        //    voteBtn.setTitle("unvote", forState: UIControlState.Normal) }
       // else {
        //    voteBtn.setTitle("vote", forState: UIControlState.Normal)

       // }
        
       // usleep(100000)
        voteBtn.enabled = false
    }
    
    
    func updateLabel (notification : NSNotification) {
        if !Player.instance.isEliminated {
            voteBtn.enabled = true }
       // voteBtn.setTitle("vote", forState: UIControlState.Normal)
        names = []
        tableView.reloadData()
        playerLbl.text = Handling.instance.receivedContent
        Handling.instance.gameState = 3
        
        
    }

    func updateTable (notification : NSNotification) {
        if names.contains(Handling.instance.receivedContent) {
            names = names.filter() { $0 != Handling.instance.receivedContent }
            tableView.reloadData()
        }
        else {
        names.append(Handling.instance.receivedContent)
            tableView.reloadData() }
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
