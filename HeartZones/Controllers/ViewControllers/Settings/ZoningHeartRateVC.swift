//
//  ZoningHeartRateVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 09/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ZoningHeartRateVC: UIViewController, UITextFieldDelegate {
    
    //outlets
    @IBOutlet weak var startingHeartRateField: UITextField!
    @IBOutlet weak var firstThresholdField: UITextField!
    @IBOutlet weak var secondThresholdField: UITextField!
    @IBOutlet weak var maxPeakHeartRateField: UITextField!
    @IBOutlet weak var redZoneValue: UILabel!
    @IBOutlet weak var yellowZoneValue: UILabel!
    @IBOutlet weak var blueZoneValue: UILabel!
    
    //properties
    var sensorType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sensorType
        
        let startingHeartRate = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCHeartRate) as? String ?? ""
        if startingHeartRate == "" {
            self.startingHeartRateField.text = "90"
            UserDefaults.standard.set("90", forKey: GlobalRoles.zoningHeartRateVCHeartRate)
            
        }
        
        let firstThreshold = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCfirstThreshold) as? String ?? ""
        if firstThreshold == "" {
            self.firstThresholdField.text = "110"
            UserDefaults.standard.set("110", forKey: GlobalRoles.zoningHeartRateVCfirstThreshold)
            
        }
        
        let secondThreshold = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCSecondThreshold) as? String ?? ""
        if secondThreshold == "" {
            self.secondThresholdField.text = "140"
            UserDefaults.standard.set("140", forKey: GlobalRoles.zoningHeartRateVCSecondThreshold)
            
        }
        
        let maxPeakThreshold = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCMaxPeakHeartRate) as? String ?? ""
        if maxPeakThreshold == "" {
            self.maxPeakHeartRateField.text = "170"
            UserDefaults.standard.set("170", forKey: GlobalRoles.zoningHeartRateVCMaxPeakHeartRate)
            
        }
        
        
        self.setUpDefaultValues()
        self.setUpZonesData()
    }
    
    
    func setUpDefaultValues() {
        self.startingHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCHeartRate) as? String ?? ""
        self.firstThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCfirstThreshold) as? String ?? ""
        self.secondThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCSecondThreshold) as? String ?? ""
        self.maxPeakHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCMaxPeakHeartRate) as? String ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let heartRateValue = Int(self.startingHeartRateField.text ?? "") ?? 0
        let firstThresholdValue = Int(self.firstThresholdField.text ?? "") ?? 0
        let secondThresholdValue = Int(self.secondThresholdField.text ?? "") ?? 0
        let maxPeakValue = Int(self.maxPeakHeartRateField.text ?? "") ?? 0
        
        
        if textField == self.startingHeartRateField {
            if heartRateValue < firstThresholdValue && heartRateValue < secondThresholdValue && heartRateValue < maxPeakValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.zoningHeartRateVCHeartRate)
                
            } else {
                self.showWarningAlert(withTitle: "Heart rate cannot be more than first threshold or second threshold or max peak heart rate", withTextField: self.startingHeartRateField)
            }
            
        } else if textField == self.firstThresholdField {
            if firstThresholdValue > heartRateValue && firstThresholdValue < secondThresholdValue && firstThresholdValue < maxPeakValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.zoningHeartRateVCfirstThreshold)
                
            } else {
                self.showWarningAlert(withTitle: "First threshold cannot be lesser than actual heart rate and cannot be more than second threshold or max peak heart rate", withTextField: self.firstThresholdField)
            }
            
        } else if textField == self.secondThresholdField {
            if secondThresholdValue > heartRateValue && secondThresholdValue > firstThresholdValue && secondThresholdValue < maxPeakValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.zoningHeartRateVCSecondThreshold)
                
            } else {
                self.showWarningAlert(withTitle: "Second threshold cannot be lesser than actual heart or first threshold and cannot be more than max peak heart rate", withTextField: self.secondThresholdField)
                
            }
        } else { //maxPeakHeartRateField
            if maxPeakValue > heartRateValue && maxPeakValue > firstThresholdValue && maxPeakValue > secondThresholdValue {
                UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.zoningHeartRateVCMaxPeakHeartRate)
                
            } else {
                self.showWarningAlert(withTitle: "Max heart rate cannot be lesser than actual heart or first threshold or second threshold", withTextField: self.maxPeakHeartRateField)
                
            }
        }
        
        self.setUpZonesData()
    }
    
    
    func showWarningAlert (withTitle:String, withTextField:UITextField) {
        let alert = UIAlertController(title: withTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in
            
            if withTextField == self.startingHeartRateField {
                self.startingHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCHeartRate) as? String ?? ""
                
            } else if withTextField == self.firstThresholdField {
                self.firstThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCfirstThreshold) as? String ?? ""
                
            } else if withTextField == self.secondThresholdField {
                self.secondThresholdField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCSecondThreshold) as? String ?? ""
                
            } else { //maxPeakHeartRateField
                self.maxPeakHeartRateField.text = UserDefaults.standard.value(forKey: GlobalRoles.zoningHeartRateVCMaxPeakHeartRate) as? String ?? ""
            }
            
            self.setUpZonesData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpZonesData() {
        let heartRate = self.startingHeartRateField.text ?? ""
        let firstThreshold = self.firstThresholdField.text ?? ""
        let secondThreshold = self.secondThresholdField.text ?? ""
        let maxPeakHeartRate = self.maxPeakHeartRateField.text ?? ""
        
        self.redZoneValue.text = "\(secondThreshold) - \(maxPeakHeartRate) bpm"
        self.yellowZoneValue.text = "\(firstThreshold) - \(secondThreshold) bpm"
        self.blueZoneValue.text = "\(heartRate) - \(firstThreshold) bpm"
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
