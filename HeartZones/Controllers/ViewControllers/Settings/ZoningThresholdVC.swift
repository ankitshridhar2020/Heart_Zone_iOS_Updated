//
//  ZoningThresholdVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 09/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ZoningThresholdVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var startingHeartRateField: UITextField!
    @IBOutlet weak var firstThresholdField: UITextField!
    @IBOutlet weak var secondThresholdField: UITextField!
    @IBOutlet weak var maxPeakHeartRateField: UITextField!
    @IBOutlet weak var zone5Label: UILabel!
    @IBOutlet weak var zone4Label: UILabel!
    @IBOutlet weak var zone3Label: UILabel!
    @IBOutlet weak var zone2Label: UILabel!
    @IBOutlet weak var zone1Label: UILabel!
    
    
    //properties
    var sensorType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sensorType
        
        let maxHeartRate = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCHeartRate) as? String ?? ""
        if maxHeartRate == "" {
            self.maxPeakHeartRateField.text = "90"
            UserDefaults.standard.set("90", forKey: GlobalRoles.thresholdVCHeartRate)

        }
        
        let firstThreshold = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT1) as? String ?? ""
        if firstThreshold == "" {
            self.firstThresholdField.text = "120"
            UserDefaults.standard.set("120", forKey: GlobalRoles.thresholdVCT1)

        }
        
        let secondThreshold = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT2) as? String ?? ""
        if secondThreshold == "" {
            self.secondThresholdField.text = "140"
            UserDefaults.standard.set("140", forKey: GlobalRoles.thresholdVCT2)
            
        }
        
        let maxPeakThreshold = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCMaxPeakHeartRate) as? String ?? ""
        if maxPeakThreshold == "" {
            self.maxPeakHeartRateField.text = "170"
            UserDefaults.standard.set("170", forKey: GlobalRoles.thresholdVCMaxPeakHeartRate)
            
        }
        
        self.setUpDefaultValues()
        self.calculateZonesData()
    }
    
    func setUpDefaultValues() {
        self.startingHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCHeartRate) as? String ?? ""
        self.firstThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT1) as? String ?? ""
        self.secondThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT2) as? String ?? ""
        self.maxPeakHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCMaxPeakHeartRate) as? String ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let heartRateValue = Int(self.startingHeartRateField.text ?? "") ?? 0
        let firstThresholdValue = Int(self.firstThresholdField.text ?? "") ?? 0
        let secondThresholdValue = Int(self.secondThresholdField.text ?? "") ?? 0
        let maxPeakValue = Int(self.maxPeakHeartRateField.text ?? "") ?? 0
        
        if textField == self.startingHeartRateField {
            if heartRateValue < firstThresholdValue && heartRateValue < secondThresholdValue && heartRateValue < maxPeakValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.thresholdVCHeartRate)
                
            } else {
                self.showWarningAlert(withTitle: "Heart rate cannot be more than first threshold or second threshold or max peak heart rate", withTextField: self.startingHeartRateField)
                
            }
        } else if textField == self.firstThresholdField {
            if firstThresholdValue > heartRateValue && firstThresholdValue < secondThresholdValue && firstThresholdValue < maxPeakValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.thresholdVCT1)

            } else {
                self.showWarningAlert(withTitle: "First threshold cannot be lesser than actual heart rate and cannot be more than second threshold or max peak heart rate", withTextField: self.firstThresholdField)

            }
            
        } else if textField == self.secondThresholdField {
            if secondThresholdValue > heartRateValue && secondThresholdValue > firstThresholdValue && secondThresholdValue < maxPeakValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.thresholdVCT2)

            } else {
                self.showWarningAlert(withTitle: "Second threshold cannot be lesser than actual heart or first threshold and cannot be more than max peak heart rate", withTextField: self.secondThresholdField)

            }
            
        } else { //maxPeakHeartRateField
            if maxPeakValue > heartRateValue && maxPeakValue > firstThresholdValue && maxPeakValue > secondThresholdValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.thresholdVCMaxPeakHeartRate)

            } else {
                self.showWarningAlert(withTitle: "Max heart rate cannot be lesser than actual heart or first threshold or second threshold", withTextField: self.maxPeakHeartRateField)
            }
        }
        
        self.calculateZonesData()
    }
    
    func showWarningAlert (withTitle:String, withTextField:UITextField) {
        let alert = UIAlertController(title: withTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in
            
            if withTextField == self.startingHeartRateField {
                self.startingHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCHeartRate) as? String ?? ""
                
            } else if withTextField == self.firstThresholdField {
                self.firstThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT1) as? String ?? ""
                
            } else if withTextField == self.secondThresholdField {
                self.secondThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCT2) as? String ?? ""
                
            } else { //maxPeakHeartRateField
                self.maxPeakHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.thresholdVCMaxPeakHeartRate) as? String ?? ""
            }
            
            self.calculateZonesData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func calculateZonesData() {
        let heartRateValue = Int(self.startingHeartRateField.text ?? "") ?? 0
        let firstThresholdValue = Int(self.firstThresholdField.text ?? "") ?? 0
        let secondThresholdValue = Int(self.secondThresholdField.text ?? "") ?? 0
        let maxPeakValue = Int(self.maxPeakHeartRateField.text ?? "") ?? 0
        
        let yellowZone = (firstThresholdValue + secondThresholdValue) / 2
        let blueZone = (heartRateValue + firstThresholdValue) / 2
        
        self.zone5Label.text = "\(secondThresholdValue)-\(maxPeakValue) bpm"
        self.zone4Label.text = "\(yellowZone)-\(secondThresholdValue) bpm"
        self.zone3Label.text = "\(firstThresholdValue)-\(yellowZone) bpm"
        self.zone2Label.text = "\(blueZone)-\(firstThresholdValue) bpm"
        self.zone1Label.text = "\(heartRateValue)-\(blueZone) bpm"
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
