//
//  ZoningMaxPeakVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 09/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ZoningMaxPeakVC: UIViewController, UITextFieldDelegate {
    
    //outlets
    @IBOutlet weak var maxHeartRateField: UITextField!
    @IBOutlet weak var zoneFiveValue: UILabel!
    @IBOutlet weak var zoneFourValue: UILabel!
    @IBOutlet weak var zoneThreeValue: UILabel!
    @IBOutlet weak var zoneTwoValue: UILabel!
    @IBOutlet weak var zoneOneValue: UILabel!
    
    
    //properties
    var sensorType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sensorType
        
        let maxHeartRate = UserDefaults.standard.value(forKey: GlobalRoles.maxPeakHeartRateVCMaxHeartRate) as? String ?? ""
        if maxHeartRate == "" {
            self.maxHeartRateField.text = "180"
            UserDefaults.standard.set("180", forKey: GlobalRoles.maxPeakHeartRateVCMaxHeartRate)
            
        }
        
        self.setUpDefaultValues()
        self.calculateZonesData()
    }
    
    func setUpDefaultValues() {
        self.maxHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.maxPeakHeartRateVCMaxHeartRate) as? String ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text?.count ?? 0 > 0 {
            UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.maxPeakHeartRateVCMaxHeartRate)

        } else {
            self.maxHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.maxPeakHeartRateVCMaxHeartRate) as? String ?? ""
            self.present(AlertUtil.showAlert(msg: "Max Heart rate cannot be empty", withTitle: ""), animated: true, completion: nil)
        }
        
        self.calculateZonesData()
    }
    
    func calculateZonesData() {
        let maxHRValue = Int(self.maxHeartRateField.text ?? "") ?? 0
        
        let redZone = 90 * maxHRValue / 100
        let orangeZone = 80 * maxHRValue / 100
        let yellowZone = 70 * maxHRValue / 100
        let greenZone = 60 * maxHRValue / 100
        let blueZone = 50 * maxHRValue / 100
        
        self.zoneFiveValue.text = "\(redZone)-\(maxHRValue) bpm"
        self.zoneFourValue.text = "\(orangeZone)-\(redZone) bpm"
        self.zoneThreeValue.text = "\(yellowZone)-\(orangeZone) bpm"
        self.zoneTwoValue.text = "\(greenZone)-\(yellowZone) bpm"
        self.zoneOneValue.text = "\(blueZone)-\(greenZone) bpm"
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
