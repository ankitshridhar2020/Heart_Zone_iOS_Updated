//
//  IndexViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class IndexViewController: BaseViewController {
    
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
    
    // MARK: - Common methods
    
    func openSignupVc() {
        let signUpVcObj: SignupViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupVc") as! SignupViewController
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    func showHomeVc() {
        let baseTabbarController: BaseTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        self.navigationController?.pushViewController(baseTabbarController, animated: true)
    }
    
    // MARK: - Button tap actions
    
    @IBAction func getStartedBtnTapped(_ sender: UIButton) {
        self.openSignupVc()
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        let loginVcObj: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
        loginVcObj.loginVcDelegate = self
        self.navigationController?.pushViewController(loginVcObj, animated: true)
    }
    
    @IBAction func skipBtnTapped(_ sender: UIButton) {
        self.showHomeVc()
    }

}

// MARK: - LoginVc delegate

extension IndexViewController: LoginVcDelegate {
    
    func signupTapped() {
        self.openSignupVc()
    }
    
}
