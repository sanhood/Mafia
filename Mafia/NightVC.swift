//
//  NightVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/31/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class NightVC: UIViewController {
    @IBOutlet weak var playerLbl : UILabel!
    @IBOutlet weak var voteBtn : UIButton!
    
    var names : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Handling.instance.receive()
        if Player.instance.isEliminated || Player.instance.role != "mafia" {
            voteBtn.enabled = false
            playerLbl.text = "GoodNight"
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabel:", name: "label", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToResultVC:", name: "resultVC", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToDay:", name: "day", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        Handling.instance.gameState = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToDay (notification : NSNotification) {
        performSegueWithIdentifier("DayVC", sender: nil)
    }
    
    
    
    func goToResultVC (notification: NSNotification) {
        performSegueWithIdentifier("ResultVC", sender: nil)
    }
    
    
    
    @IBAction func onVoteTapped (sender : AnyObject) {
        if Player.instance.role == "mafia" {
            Handling.instance.send("mafiaVote") }
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
        playerLbl.text = Handling.instance.receivedContent
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
