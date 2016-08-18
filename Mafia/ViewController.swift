//
//  ViewController.swift
//  Mafia
//
//  Created by Dani on 8/12/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//

import UIKit
import CFNetwork

class ViewController: UIViewController {
    
    var inputstream : NSInputStream!
    var outputstream : NSOutputStream!
    
    

    @IBOutlet weak var BC: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        AnimateBc()
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


}

