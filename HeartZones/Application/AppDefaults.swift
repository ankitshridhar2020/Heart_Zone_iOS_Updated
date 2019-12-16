//
//  AppDefaults.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

var auth_token: String {
    get {
        guard let userAuthToken: String = UserDefaults.standard.object(forKey: "auth_token") as? String else {
            return EMPTY_STRING
        }
        return userAuthToken
    }set (newValue) {
        UserDefaults.standard.set(newValue, forKey: "auth_token")
        UserDefaults.standard.synchronize()
    }
}
