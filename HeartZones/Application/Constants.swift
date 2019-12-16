//
//  Constants.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Global objects

let APP_WINDOW: UIWindow = UIApplication.shared.delegate!.window!!
let APP_DELEGATE: AppDelegate = UIApplication.shared.delegate as! AppDelegate
let EMPTY_STRING: String = String()
let EMPTY_PARAMS: NSDictionary = NSDictionary()
let APP_TITLE: String = "Heart Zones"

// MARK: - Notification identifiers

let INVALID_USER_ACCESS_TOKEN_NOTIFICATION = Notification.Name("InvalidUserAccessToken")

// MARK: - Common Methods

let LOADING_POPUP_TEXT = "Loading.."

// MARK: - Common Device Constants

struct ScreenSize {
    static let SCREEN_WIDTH       = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT      = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH  = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH  = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_8          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_8P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

// MARK: - Common Error Objects

let NO_NETWORK_ERROR: NSError = NSError(domain: "ServiceUnavailable", code: 503, userInfo: [NSLocalizedDescriptionKey: "Sorry! There is no network connection found, please try again later."])

func getFailureError(_ errorMessage: String) -> NSError {
    return NSError(domain: "UnprocessableEntity", code: 422, userInfo:[NSLocalizedDescriptionKey: errorMessage])
}

func getApiResponseFailureError(_ response: NSDictionary, errorCode: Int) -> NSError {
    if let strError: String = response["error"] as? String, !strError.isEmpty {
        return NSError(domain: "HttpResponseError", code: errorCode, userInfo:[NSLocalizedDescriptionKey: strError])
    }else if let strMessage: String = response["errors"] as? String, !strMessage.isEmpty {
        return NSError(domain: "HttpResponseError", code: errorCode, userInfo:[NSLocalizedDescriptionKey: strMessage])
    }else if let errorsArray: NSArray = response["errors"] as? NSArray, errorsArray.count != 0 {
        var strErrors: String = String()
        for (index, element) in errorsArray.enumerated() {
            strErrors = (index == 0) ? (element as! String) : (strErrors + ", \((element as! String))")
        }
        return NSError(domain: "HttpResponseError", code: errorCode, userInfo:[NSLocalizedDescriptionKey: strErrors])
    }
    return NSError(domain: "HttpResponseError", code: errorCode, userInfo:[NSLocalizedDescriptionKey: "UnKnown server error."])
}


enum PeripheralNotificationKeys : String { // The notification name of peripheral
    case DisconnectNotif = "disconnectNotif" // Disconnect notification name
    case CharacteristicNotif = "characteristicNotif" // Characteristic discover notification name
}

