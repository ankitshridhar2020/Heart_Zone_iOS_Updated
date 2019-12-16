//
//  BaseTabBarController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Foundation
import Toaster

class BaseTabBarController: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 0
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    // MARK: - UIView lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
    
    //For increasing height of default tab bar
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let newTabBarHeight = defaultTabBarHeight + 0
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.frame = newFrame
    }


}
