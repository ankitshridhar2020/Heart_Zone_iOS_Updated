//
//  SettingsViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, UITextFieldDelegate {
    
    //outlets
    @IBOutlet weak var unitsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var weightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var selectBirthDateBtn: UIButton!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var zoneMethodologyName: UIButton!
    @IBOutlet weak var kgLbsLabel: UILabel!
    
    
    //properties
    var userWeight = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional before appear the view.
        // remove left buttons (in case you added some)
        self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
        
        
        let selectedZone = UserDefaults.standard.value(forKey: GlobalRoles.selectedZone) as? Int ?? 0
        if selectedZone == 0 {
            self.zoneMethodologyName.setTitle("Zoning Heart Rate", for: .normal)
            
        } else if selectedZone == 1 {
            self.zoneMethodologyName.setTitle("Max/peak Heart Rate", for: .normal)
            
        } else {
            self.zoneMethodologyName.setTitle("Threshold Heart Rate", for: .normal)
        }
        
        
        let userWeight = UserDefaults.standard.value(forKey: GlobalRoles.userWeight) as? String ?? ""
        if userWeight == "" {
            self.weightField.text = "75"
            self.userWeight = 75
            
        } else {
            self.weightField.text = userWeight
            self.userWeight = Int(userWeight) ?? 0
        }
        
        
        let userAge = UserDefaults.standard.value(forKey: GlobalRoles.userAge) as? String ?? ""
        if userAge == "" {
            self.ageField.text = "25"
            
        } else {
            self.ageField.text = userAge
        }
        
        
        let selectedMetric = UserDefaults.standard.value(forKey: GlobalRoles.settingsUnit) as? Int ?? 0
        if selectedMetric == 0 {
            self.unitsSegmentedControl.selectedSegmentIndex = 0
            self.kgLbsLabel.text = "kgs"
            
        } else {
            self.unitsSegmentedControl.selectedSegmentIndex = 1
            self.kgLbsLabel.text = "lbs"
        }
        
        
        let selectedGender = UserDefaults.standard.value(forKey: GlobalRoles.userGender) as? Int ?? 0
        if selectedGender == 0 {
            self.genderSegmentedControl.selectedSegmentIndex = 0
            
        } else {
            self.genderSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.weightField {
            UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.userWeight)
            self.userWeight = Int(textField.text ?? "0") ?? 0
            
        } else { //ageField
            UserDefaults.standard.set(textField.text ?? "", forKey: GlobalRoles.userAge)
        }
    }
    
    @IBAction func selectBirthDateBtnTapped(_ sender: UIButton) {
        var tickerMoved = false
        let todaysDate = Date()
        var selectedDate = Date()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        
        let actionSheet = UIAlertController(title: "Select Birth Date", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: todaysDate) { date in
            selectedDate = date
            UserDefaults.standard.set(date.toString(dateFormat: "dd/MM/yyyy"), forKey: GlobalRoles.userDOB)

            let ageComponents = calendar.components(.year, from: date, to: todaysDate, options: .matchFirst)
            let age = ageComponents.year ?? 0
            self.ageField.text = "\(age)"
            UserDefaults.standard.set("\(age)", forKey: GlobalRoles.userAge)
            tickerMoved = true
            
        }
        actionSheet.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.cancel, handler: { (action) in
            if tickerMoved {
                UserDefaults.standard.set(selectedDate.toString(dateFormat: "dd/MM/yyyy"), forKey: GlobalRoles.userDOB)

                let ageComponents = calendar.components(.year, from: selectedDate, to: todaysDate, options: .matchFirst)
                let age = ageComponents.year ?? 0
                self.ageField.text = "\(age)"
                UserDefaults.standard.set("\(age)", forKey: GlobalRoles.userAge)
                
            } else {
                UserDefaults.standard.set(todaysDate.toString(dateFormat: "dd/MM/yyyy"), forKey: GlobalRoles.userDOB)

                let ageComponents = calendar.components(.year, from: todaysDate, to: todaysDate, options: .matchFirst)
                let age = ageComponents.year ?? 0
                self.ageField.text = "\(age)"
                UserDefaults.standard.set("\(age)", forKey: GlobalRoles.userAge)
                
            }
            
            actionSheet.dismiss(animated: true, completion: nil)
        }))
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: UIScreen.main.bounds.height, width: 0, height: 0)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func unitsSegmentedControlTapped(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(0, forKey: GlobalRoles.settingsUnit)
            
            let kiloWeight = Double(self.userWeight) * 0.453592
            let kiloWeightInt = Int(kiloWeight)
            self.userWeight = kiloWeightInt
            UserDefaults.standard.set("\(kiloWeightInt)", forKey: GlobalRoles.userWeight)
            self.weightField.text = "\(kiloWeightInt)"
            self.kgLbsLabel.text = "kgs"
            
        } else {
            UserDefaults.standard.set(1, forKey: GlobalRoles.settingsUnit)
            
            let lbsWeight = Double(self.userWeight) * 2.20462
            let lbsInt = Int(lbsWeight)
            self.userWeight = lbsInt
            UserDefaults.standard.set("\(lbsInt)", forKey: GlobalRoles.userWeight)
            self.weightField.text = "\(lbsInt)"
            self.kgLbsLabel.text = "lbs"
        }
        
    }
    
    @IBAction func genderSegmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(0, forKey: GlobalRoles.userGender)
            
        } else {
            UserDefaults.standard.set(1, forKey: GlobalRoles.userGender)
        }
    }
    
    @IBAction func weightSegmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.userWeight -= 1
            UserDefaults.standard.set("\(self.userWeight)", forKey: GlobalRoles.userWeight)
            self.weightField.text = "\(self.userWeight)"

        } else {
            self.userWeight += 1
            UserDefaults.standard.set("\(self.self.userWeight)", forKey: GlobalRoles.userWeight)
            self.weightField.text = "\(self.userWeight)"

        }
    }
    
    @IBAction func MaxAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "ZonesMethodologyVC") as! ZonesMethodologyVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    
    @IBAction func StrideAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "StrideVC") as! StrideVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    @IBAction func CyclingAction(_ sender: Any) {
        
    }
    
}
