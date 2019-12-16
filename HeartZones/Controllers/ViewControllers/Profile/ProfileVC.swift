//
//  ProfileVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 02/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //outlets
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var zonesField: UITextField!
    @IBOutlet weak var thresholdT1Field: UITextField!
    @IBOutlet weak var thresholdT2Field: UITextField!
    @IBOutlet weak var maxHRField: UITextField!
    @IBOutlet weak var storedWorkoutField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.setupData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setupData() {
        let userGender = UserDefaults.standard.value(forKey: GlobalRoles.userGender) as? Int ?? 0
        if userGender == 0 {
            self.genderField.text = "Male"
            
        } else {
            self.genderField.text = "Female"
        }
        
        self.ageField.text = UserDefaults.standard.value(forKey: GlobalRoles.userAge) as? String ?? ""
        self.dobField.text = UserDefaults.standard.value(forKey: GlobalRoles.userDOB) as? String ?? ""
        
        let selectedMetric = UserDefaults.standard.value(forKey: GlobalRoles.settingsUnit) as? Int ?? 0
        let userWeight = UserDefaults.standard.value(forKey: GlobalRoles.userWeight) as? String ?? ""
        if selectedMetric == 0 {
            self.weightField.text = userWeight + " kgs"
            
        } else {
            self.weightField.text = userWeight + " lbs"
        }
        
        let t1Value = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT1) as? String ?? ""
        let t2Value = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT2) as? String ?? ""
        self.thresholdT1Field.text = "T1: \(t1Value)"
        self.thresholdT2Field.text = "T2: \(t2Value)"
        
        self.weightField.text = UserDefaults.standard.value(forKey: GlobalRoles.userWeight) as? String ?? ""
        self.maxHRField.text = UserDefaults.standard.value(forKey: GlobalRoles.maxPeakHeartRateVCMaxHeartRate) as? String ?? ""
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
