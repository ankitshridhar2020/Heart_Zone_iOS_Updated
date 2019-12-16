//
//  LoginViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Toaster

protocol LoginVcDelegate {
    func signupTapped()
}

class LoginViewController: BaseViewController {
    
    @IBOutlet var userNameTxtField: HeartZonesTextFields? {
        didSet {
            self.userNameTxtField?.initializeCustomTextField(withSecuredEntery: false)
        }
    }
    @IBOutlet var passwordTxtField: HeartZonesTextFields? {
        didSet {
            self.passwordTxtField?.initializeCustomTextField(withSecuredEntery: true)
        }
    }
    @IBOutlet var rememberMeBtn: UIButton? {
        didSet{
            self.rememberMeBtn?.layer.borderWidth = 1.5
            self.rememberMeBtn?.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    var loginVcDelegate: LoginVcDelegate?
    
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
    
    func login_apiCall() {
        self.showHomeVc()
    }
    
    // Button tap actions
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let validationError: String = self.validate_textField_data()
        validationError.isEmpty ? self.login_apiCall() : Toast(text:validationError).show()
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.loginVcDelegate?.signupTapped()
    }
    
    @IBAction func forgotPasswordBtnTapped(_ sender: UIButton) {
    
    }
    
    @IBAction func rememberMeBtnTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "tick"), for: .normal)
            sender.tag = 1
        }else {
            sender.tag = 0
            sender.setImage(UIImage(named: ""), for: .normal)
        }
    }
    
    @IBAction func passwordEyeTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "eye_cancel"), for: .normal)
            sender.tag = 1
            self.passwordTxtField?.isSecureTextEntry = false
        }else {
            sender.setImage(UIImage(named: "eye"), for: .normal)
            sender.tag = 0
            self.passwordTxtField?.isSecureTextEntry = true
        }
    }
    
    // MARK: - Common methods
    
    func showHomeVc() {
        let baseTabbarController: BaseTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        self.navigationController?.pushViewController(baseTabbarController, animated: true)
    }
    
    func validate_textField_data() -> String {
        var validateError: String = String()
        if self.userNameTxtField!.text!.isEmpty {
            validateError = "Please enter username."
        }else if !self.userNameTxtField!.text!.isValidEmailAddress() {
            validateError = "Please enter valid username."
        }else if self.passwordTxtField!.text!.isEmpty {
            validateError = "Please enter Password."
        }
        return validateError
    }

}
