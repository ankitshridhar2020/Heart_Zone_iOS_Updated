//
//  SensorAlertVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 02/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SensorAlertVC: UIViewController {

    @IBOutlet weak var btnancel: UIButton!
    @IBOutlet weak var btnRetry: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnRetry.layer.cornerRadius = 12
        btnancel.layer.cornerRadius = 12
        btnRetry.layer.masksToBounds = true
        btnancel.layer.masksToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
