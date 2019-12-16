//
//  HeartZonesTextFields.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class HeartZonesTextFields : UITextField {
    
    func initializeCustomTextField(withSecuredEntery: Bool) {
        self.returnKeyType = UIReturnKeyType.done
        self.leftViewMode = UITextField.ViewMode.always
        self.backgroundColor = UIColor.clear
        self.borderStyle = .roundedRect
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        if withSecuredEntery {
            self.isSecureTextEntry = true
        }
    }
    
    func initializeCurrencyTextField_ImageName(_ imageName: String) {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 11, y: 14, width: 14, height: 14)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        let rightImage = UIView(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
        rightImage.addSubview(imageView)
        self.rightView = rightImage
        self.rightViewMode = .always
        self.borderStyle = .roundedRect
        let leftImage = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 5))
        self.leftView = leftImage
        self.leftViewMode = .always
        self.returnKeyType = UIReturnKeyType.done
    }
}
