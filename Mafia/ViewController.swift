//
//  ViewController.swift
//  Mafia
//
//  Created by Dani on 8/12/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var BC: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        AnimateBc()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    //For BackGround Animation
    func AnimateBc(){
        var Backarray = [UIImage]()
        for var x=1 ; x<=31 ; x++ {
            let BcImage = UIImage(named: "\(x)")
            Backarray.append(BcImage!)
        }
        BC.animationImages = Backarray
        BC.animationDuration = 2
        BC.animationRepeatCount=0
        BC.startAnimating()
    }
    //
    @IBAction func onStartTapped (sender : AnyObject) {
        performSegueWithIdentifier("JoinVC", sender: nil)
    }

}

