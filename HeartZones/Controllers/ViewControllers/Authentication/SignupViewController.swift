//
//  SignupViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Toaster

class SignupViewController: BaseViewController {
    
    @IBOutlet var firstNameTxtField: HeartZonesTextFields? {
        didSet {
            self.firstNameTxtField?.initializeCustomTextField(withSecuredEntery: false)
        }
    }
    @IBOutlet var lastNameTxtField: HeartZonesTextFields? {
        didSet {
            self.lastNameTxtField?.initializeCustomTextField(withSecuredEntery: false)
        }
    }
    @IBOutlet var organizationtNameTxtField: HeartZonesTextFields? {
        didSet {
            self.organizationtNameTxtField?.initializeCustomTextField(withSecuredEntery: false)
        }
    }
    @IBOutlet var organizationIdTxtField: HeartZonesTextFields? {
        didSet {
            self.organizationIdTxtField?.initializeCustomTextField(withSecuredEntery: false)
        }
    }
    @IBOutlet var emailTxtField: HeartZonesTextFields? {
        didSet {
            self.emailTxtField?.initializeCustomTextField(withSecuredEntery: false)
        }
    }
    @IBOutlet var passwordTxtField: HeartZonesTextFields? {
        didSet {
            self.passwordTxtField?.initializeCustomTextField(withSecuredEntery: true)
        }
    }
    @IBOutlet var confirmPasswordTxtField: HeartZonesTextFields? {
        didSet {
            self.confirmPasswordTxtField?.initializeCustomTextField(withSecuredEntery: true)
        }
    }
    
    // MARK:- view controller life cycle methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
    }
    
    // MARK: - Api calls
    
    func signup_apiCall() {
        
    }
    
    // MARK: - Button tap actions
    
    @IBAction func signupBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let validationError: String = self.validate_textField_data()
        validationError.isEmpty ? self.signup_apiCall() : Toast(text:validationError).show()
    }
    
    // MARK: - Common methods
    
    func validate_textField_data() -> String {
        var validateError: String = String()
        if self.firstNameTxtField!.text!.isEmpty {
            validateError = "Please enter name."
        }else if self.lastNameTxtField!.text!.isEmpty {
            validateError = "Please enter surname."
        }else if self.organizationIdTxtField!.text!.isEmpty {
            validateError = "Please enter organization name."
        }else if self.organizationIdTxtField!.text!.isEmpty {
            validateError = "Please enter organization ID."
        }else if self.emailTxtField!.text!.isEmpty {
            validateError = "Please enter Email."
        }else if !self.emailTxtField!.text!.isValidEmailAddress() {
            validateError = "Please enter valid Email."
        }else if self.passwordTxtField!.text!.isEmpty {
            validateError = "Please enter any Password."
        }else if self.confirmPasswordTxtField!.text!.isEmpty {
            validateError = "Please confirm Password."
        }else if self.passwordTxtField!.text! != self.confirmPasswordTxtField!.text! {
            validateError = "Passwords do not match."
        }
        return validateError
    }

}
