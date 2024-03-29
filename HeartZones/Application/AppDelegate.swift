//
//  AppDelegate.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import Toaster

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // sleep(10)
        ReachabilityManager.shared.startMonitoring()
        IQKeyboardManager.shared.enable = true
        self.configureSVProgressHUD_and_toast_appearance()
//        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//            statusBar.backgroundColor = UIColor.init(red: 175.0/255.0, green: 35.0/255.0, blue: 28.0/255.0, alpha: 1.0)
//
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - SVProgressHUD/Toaster method
    
    func configureSVProgressHUD_and_toast_appearance() {
        // Setup SVProgressHUD
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setForegroundColor(UIColor.white)                            //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.heartZonesLoadingViewColor())        //HUD Color
        SVProgressHUD.setMinimumSize(CGSize( width: 130, height: 100))
        SVProgressHUD.setFont(UIFont.semiBoldFontOfSize(size: 17.0))
        SVProgressHUD.setRingThickness(5.0)
        SVProgressHUD.setRingRadius(22.0)
        // Setup ToastView
        ToastView.appearance().backgroundColor = UIColor.darkGray
        ToastView.appearance().textColor = UIColor.white
        ToastView.appearance().font = UIFont.semiBoldFontOfSize(size: 15.0)
        ToastView.appearance().textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        ToastView.appearance().bottomOffsetPortrait = 25
        ToastView.appearance().cornerRadius = 5
    }


}

