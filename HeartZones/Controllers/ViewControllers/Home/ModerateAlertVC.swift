//
//  ModerateAlertVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 09/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

protocol ModerateVcDelegate {
    func ModerateTapped(strType:String)
}

class ModerateAlertVC: UIViewController {
   
    @IBOutlet weak var btnDiscard: UIButton!
    @IBOutlet weak var btn2Recovery: UIButton!
    @IBOutlet weak var btn1Recovery1: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnResume: UIButton!
    
     var ModerateVcDelegate: ModerateVcDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       btnResume.layer.cornerRadius = 8
       btnResume.layer.borderWidth = 1
       btnResume.layer.borderColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0).cgColor
        
        btnSave.layer.cornerRadius = 8
        btnSave.layer.borderWidth = 1
        btnSave.layer.borderColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0).cgColor
        
        btn1Recovery1.layer.cornerRadius = 8
        btn1Recovery1.layer.borderWidth = 1
        btn1Recovery1.layer.borderColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0).cgColor
        
        btn2Recovery.layer.cornerRadius = 8
        btn2Recovery.layer.borderWidth = 1
        btn2Recovery.layer.borderColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0).cgColor
        
        btnDiscard.layer.cornerRadius = 8
        btnDiscard.layer.borderWidth = 1
        btnDiscard.layer.borderColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0).cgColor
    }
    
     // MARK: - Action Method
    
    @IBAction func ResumeAction(_ sender: Any) {
        ModerateVcDelegate?.ModerateTapped(strType: "Resume")
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveAction(_ sender: Any) {
         ModerateVcDelegate?.ModerateTapped(strType: "Save")
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Recovery1Action(_ sender: Any) {
        ModerateVcDelegate?.ModerateTapped(strType: "Recovery1")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Recovery2Action(_ sender: Any) {
        ModerateVcDelegate?.ModerateTapped(strType: "Recover2")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DiscardAction(_ sender: Any) {
         ModerateVcDelegate?.ModerateTapped(strType: "Discard")
        self.dismiss(animated: true, completion: nil)
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
