//
//  ConnectionVC.swift
//  SmartSearching
//
//  Created by Janmejay Parmar on 23/10/19.
//  Copyright © 2019 Atto Infotech. All rights reserved.
//

import UIKit
import CoreBluetooth

class ConnectionVC: UIViewController, BluetoothDelegate {

    //outlets
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var deviceID: UILabel!
    @IBOutlet weak var deviceState: UILabel!
    
    
    //properties
    var lastAdvertisementData : Dictionary<String, Any>?
    fileprivate var charDic = [CBUUID : [CBCharacteristic]]()
    fileprivate let bluetoothManager = BluetoothManager.getInstance()
    fileprivate var services : [CBService]?
    fileprivate var advertisementDataKeys : [String]?
    var characteristic : CBCharacteristic?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My sensor"
        
        advertisementDataKeys = ([String](lastAdvertisementData!.keys)).sorted()
        bluetoothManager.discoverCharacteristics()
        services = bluetoothManager.connectedPeripheral?.services
        self.deviceName.text = bluetoothManager.connectedPeripheral?.name
        self.deviceID.text = bluetoothManager.connectedPeripheral?.identifier.uuidString
        self.deviceState.text = "Deice state: Connected"
        
        
//        let abcd = charDic[services![0].uuid]!
//        self.bluetoothManager.setNotification(enable: true, forCharacteristic: abcd.first!)

    }
    
    func didDiscoverDescriptors(_ characteristic: CBCharacteristic) {
        print("Device location: \(bodyLocation(from: characteristic))")
    }
    
    private func bodyLocation(from characteristic: CBCharacteristic) -> String {
        guard let characteristicData = characteristic.value,
            let byte = characteristicData.first else { return "Error" }
        
        switch byte {
        case 0: return "Other"
        case 1: return "Chest"
        case 2: return "Wrist"
        case 3: return "Finger"
        case 4: return "Hand"
        case 5: return "Ear Lobe"
        case 6: return "Foot"
        default:
            return "Reserved for future use"
        }
    }
}
