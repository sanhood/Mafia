//
//  ResultVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/31/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Handling.instance.receive()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabel:", name: "result", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "eliminated:", name: "eliminated", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToNightVC:", name: "night", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabel (notification : NSNotification) {
            resultLbl.text = Handling.instance.receivedContent
    }
    
    func eliminated (notification : NSNotification) {
        Player.instance.isEliminated = true
    }
    
    func goToNightVC (notification : NSNotification) {
        performSegueWithIdentifier("NightVC", sender: nil)
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
