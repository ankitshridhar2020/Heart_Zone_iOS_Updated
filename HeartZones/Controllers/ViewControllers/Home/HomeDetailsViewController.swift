//
//  HomeDetailsViewController.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 01/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgGo: UIImageView!
    @IBOutlet weak var img60Vigorous: UIImageView!
    @IBOutlet weak var img45Moderate: UIImageView!
    @IBOutlet weak var img30Easy: UIImageView!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var btnVigorous: UIButton!
    @IBOutlet weak var btnModerate: UIButton!
    @IBOutlet weak var btnEasy: UIButton!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imglogo: UIImageView!
  
    var strtype: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if(strtype == "Walk"){
            imglogo.image = UIImage.init(named: "walk-run")
            lblType.text = "Walk/Run"
            btnGo.isEnabled = false
            btnEasy.isEnabled = false
            btnModerate.isEnabled = true
            btnVigorous.isEnabled = false
            
        }else if(strtype == "Heart"){
            imglogo.image = UIImage.init(named: "heartrate")
            lblType.text = "HeartRate"
            btnGo.isEnabled = false
            btnEasy.isEnabled = true
            btnModerate.isEnabled = false
            btnVigorous.isEnabled = false
        }else if(strtype == "Cycle"){
            imglogo.image = UIImage.init(named: "cycle")
            lblType.text = "Cycle"
            btnGo.isEnabled = false
            btnEasy.isEnabled = false
            btnModerate.isEnabled = false
            btnVigorous.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
         self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK:- Action Method
    
    @IBAction func ProfileAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    @IBAction func EasyAction(_ sender: Any) {
        img30Easy.image = UIImage.init(named: "30min-selected")
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsEasyVC") as! HomeDetailsEasyVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    @IBAction func ModerateAction(_ sender: Any) {
         img45Moderate.image = UIImage.init(named: "45min-selected")
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsModerateVC") as! HomeDetailsModerateVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    @IBAction func CycleAction(_ sender: Any) {
        img60Vigorous.image = UIImage.init(named: "60min-selected")
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsCycleVC") as! HomeDetailsCycleVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
 
}

