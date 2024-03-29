//
//  CBCharacteristicProperties+.swift
//  HZone
//
//  Created by Janmejay Parmar on 2019/10/28.
//  Copyright © 2019 HZone. All rights reserved.
//

import CoreBluetooth

extension CBCharacteristicProperties {
    public var names: [String] {
        var resultProperties = [String]()
        if contains(.broadcast) {
            resultProperties.append("Broadcast")
        }
        if contains(.read) {
            resultProperties.append("Read")
        }
        if contains(.write) {
            resultProperties.append("Write")
        }
        if contains(.writeWithoutResponse) {
            resultProperties.append("Write Without Response")
        }
        if contains(.notify) {
            resultProperties.append("Notify")
        }
        if contains(.indicate) {
            resultProperties.append("Indicate")
        }
        if contains(.authenticatedSignedWrites) {
            resultProperties.append("Authenticated Signed Writes")
        }
        if contains(.extendedProperties) {
            resultProperties.append("Extended Properties")
        }
        if contains(.notifyEncryptionRequired) {
            resultProperties.append("Notify Encryption Required")
        }
        if contains(.indicateEncryptionRequired) {
            resultProperties.append("Indicate Encryption Required")
        }
        return resultProperties
    }
}
