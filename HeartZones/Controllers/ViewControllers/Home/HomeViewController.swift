//
//  HomeViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

  //  @IBOutlet weak var view1topconstraint: NSLayoutConstraint!
   // @IBOutlet weak var viewtopConstrant: NSLayoutConstraint!
  //  @IBOutlet weak var view1: UIView!
    // MARK:- view controller life cycle methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // self.view.backgroundColor?.theGradientBackground(backgroundView: self.view, hexColor1: "FFFFFF", hexColor2: "000000")
      
      
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Do any additional before appear the view.
//        // self.navigationController?.isNavigationBarHidden = true
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
//            let logoImage1 = UIImageView()
//            logoImage1.image = UIImage(named: "heart-zones-logo")!
//            logoImage1.contentMode = .scaleAspectFit // OR .scaleAspectFill
//            // logoImage1.clipsToBounds = true
//            self.navigationItem.titleView = logoImage1
//            break
//        // It's an iPhone
//        case .pad:
//           // self.viewtopConstrant.constant = 120
//            self.view1topconstraint.constant = -60
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
//            let logoImage1 = UIImageView()
//            logoImage1.image = UIImage(named: "heart-zones-logo")!
//            self.navigationItem.titleView = logoImage1
//            break
//            // It's an iPad
//
//        case .unspecified: break
//        case .tv:
//            break
//        case .carPlay:
//            break
//        @unknown default:
//            break
//        }
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
    }
    
    // MARK:- ACTION METHOD
    
    
    @IBAction func Profile(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    @IBAction func WalkaAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        objGallery.strtype = "Walk"
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
  
    @IBAction func HeartAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
         objGallery.strtype = "Heart"
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    @IBAction func CycleAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        objGallery.strtype = "Cycle"
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
}
