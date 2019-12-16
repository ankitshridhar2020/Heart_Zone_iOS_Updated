//
//  Alert+HeartZones.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func alertOnError(error:NSError, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message:error.localizedDescription, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler:handler))
        return alert
    }
    
    class func alertOnErrorWithMessage(message:String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:handler))
        return alert
    }
    
    class func alertWithTitleAndMessage(title:String, message:String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:handler))
        return alert
    }
    
    class func alertWithMessage(message:String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:handler))
        return alert
    }
    
    class func confirmAlertWithOkAndCancel(message:String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Confirm", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:handler))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler:handler))
        return alert
    }
    
    class func confirmAlertWithTwoButtonTitles(title:String, message:String, btnTitle1:String, btnTitle2:String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle1, style: .destructive, handler:nil))
        alert.addAction(UIAlertAction(title: btnTitle2, style: .default, handler:handler))
        return alert
    }
    
}


