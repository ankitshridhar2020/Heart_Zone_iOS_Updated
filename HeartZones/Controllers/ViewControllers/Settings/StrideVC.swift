//
//  StrideVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 10/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class StrideVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Action Method
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
