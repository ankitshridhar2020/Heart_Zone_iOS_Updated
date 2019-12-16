//
//  BaseViewController.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK:- view controller life cycle methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeDefaultNotifications()
        self.setupNavigationBarDefaulyLayoutView()
        self.showLeftIconOnNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Common methods.
    
    func showNoDataLabelOnTableView(_ objTableView: UITableView, labelText: String) {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: objTableView.bounds.size.width, height: objTableView.bounds.size.height))
        messageLabel.text = labelText
        messageLabel.textColor = UIColor.appPurpleThemeColor()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.normalFontOfSize(size: 17.0)
        messageLabel.sizeToFit()
        objTableView.backgroundView = messageLabel
    }
    
    func hideNoDataLabelFromTableView(_ objTableView: UITableView) {
        objTableView.backgroundView = nil
    }
    
    func navigateUserToRootViewController() {
        self.view.endEditing(true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Notification selector methods.
    
    @objc func logoutUserAndReset_allDataNotification(notification: Notification) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        self.navigateUserToRootViewController()
    }
    
    // MARK: - initialize notifications method.
    
    func initializeDefaultNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUserAndReset_allDataNotification(notification:)), name: INVALID_USER_ACCESS_TOKEN_NOTIFICATION , object: nil)
    }
    
    //MARK:- Navigation Bar Setup Methods
    
    func setupNavigationBarDefaulyLayoutView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.appNavBarColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont.mediumFontOfSize(size: 22.0)]
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = true
    }
    
    func showLeftIconOnNavigationBar() {
        let menuButton = UIButton(type: UIButton.ButtonType.custom)
        menuButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        menuButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        menuButton.setImage(UIImage(named: "back"), for: UIControl.State())
        let menuBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
    }
    
    @objc func leftBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

