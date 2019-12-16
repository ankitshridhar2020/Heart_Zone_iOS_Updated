//
//  ButtonBorderSubView.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 09/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ButtonBorderSubView: UIButton {
    
    @IBInspectable var brderwidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0)
    
     override func draw(_ rect: CGRect) {
        layer.cornerRadius = 8
        layer.borderWidth = brderwidth
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
        
    }
}
