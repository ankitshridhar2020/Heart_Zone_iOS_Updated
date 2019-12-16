//
//  User.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var date_of_birth: String?
    var email: String?
    var gender: String?
    var id: Int64?
    var name: String?
    var phone: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        date_of_birth <- map["date_of_birth"]
        email <- map["email"]
        gender <- map["gender"]
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
    }
}
