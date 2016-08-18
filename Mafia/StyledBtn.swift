//
//  StyledBtn.swift
//  Mafia
//
//  Created by Dani on 8/13/16.
//  Copyright © 2016 Danoosh Chamani. All rights reserved.
//
import UIKit

class StyledBtn: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 4.0
        layer.shadowColor = UIColor(red: Shadow_Color, green: Shadow_Color, blue: Shadow_Color, alpha: 0.5).CGColor
        layer.shadowOpacity=1
        layer.shadowRadius=5.0
        layer.shadowOffset = CGSizeMake(0.0,0.0)
    }
}
