//
//  CBService+.swift
//  HZone
//
//  Created by Janmejay Parmar on 2019/10/28.
//  Copyright © 2019 HZone. All rights reserved.
//

import CoreBluetooth


extension CBService {
    /// Obtain the name of the characteristic according to the UUID, if the UUID is the standard defined in the `Bluetooth Developer Portal` then return the name
    public var name : String {
        guard let name = self.uuid.name else {
            return "UUID: " + self.uuid.uuidString
        }
        return name
    }
    
}
