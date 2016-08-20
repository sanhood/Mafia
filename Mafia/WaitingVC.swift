//
//  WaitingVC.swift
//  Mafia
//
//  Created by Soroush Shahi on 8/19/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit

class WaitingVC: UIViewController {
    @IBOutlet weak var label1 : UILabel!
    @IBOutlet weak var label2 : UILabel!
    
    
    
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
        // Do any additional setup after loading the view.
        label1.text = Player.instance.name
        Handling.instance.receive()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView:", name: "updateView", object: nil)
    }
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateView (notification: NSNotification) {
        if (Handling.instance.receivedContent != Player.instance.name){
            label2.text = Handling.instance.receivedContent}
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
