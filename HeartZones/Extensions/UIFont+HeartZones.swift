//
//  UIFont+HeartZones.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func normalFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Verdana", size: size)!
    }
    
    class func italicFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: size)!
    }
    
    class func boldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Verdana-Bold", size: size)!
    }
    
    class func semiBoldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func mediumFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func lightFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    class func thinFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Thin", size: size)!
    }
    
    class func ultraLightFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-UltraLight", size: size)!
    }
    
    class func heartZonesTextFieldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "SFCompactDisplay-Semibold", size: size)!
    }
}
