//
//  viewBorderSubView.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 17/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class viewBorderSubView: UIView {

    @IBInspectable var brderwidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = .white

    override func layoutSubviews() {
        layer.cornerRadius = 8
        layer.borderWidth = brderwidth
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
       
    }
}
