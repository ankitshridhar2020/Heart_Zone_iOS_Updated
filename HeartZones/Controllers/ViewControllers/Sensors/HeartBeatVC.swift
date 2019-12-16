//
//  HeartBeatVC.swift
//  SmartSearching
//
//  Created by Janmejay Parmar on 01/11/19.
//  Copyright © 2019 Atto Infotech. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol didDisconnectSensorDelegate {
    func sensorDisconnected(withMessage: String)
}

class HeartBeatVC: UIViewController, BluetoothDelegate {
    
    //outlets
    @IBOutlet weak var sensorName: UILabel!
    @IBOutlet weak var udid: UILabel!
    @IBOutlet weak var heartBeat: UILabel!
    @IBOutlet weak var sensorStrengthProgress: UIProgressView!
    @IBOutlet weak var disconnectBtn: UIButton!
    
    //properties
    var delegate:didDisconnectSensorDelegate?
    var bluetoothManager : BluetoothManager = BluetoothManager.getInstance()
    var characteristic : CBCharacteristic?
    fileprivate var services = [CBService]()
    var lastAdvertisementData : Dictionary<String, Any>?
    fileprivate var characteristicsDic = [CBUUID : [CBCharacteristic]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heart Rate"
        
        self.bluetoothManager.delegate = self
        self.bluetoothManager.discoverCharacteristics()
        if let services = bluetoothManager.connectedPeripheral?.services {
            self.services = services
        }
        
        self.sensorName.text = bluetoothManager.connectedPeripheral?.name
        let udidName = bluetoothManager.connectedPeripheral?.identifier.uuidString ?? ""
        self.udid.text = "UDID: \(udidName)"
    }
    
    func didDiscoverCharacteritics(_ service: CBService) {
        print("Service.characteristics:\(service.characteristics?.description ?? "Unknow Characteristics")")
        characteristicsDic[service.uuid] = service.characteristics
        
        self.characteristic = characteristicsDic[services[0].uuid]![0]
        assert(characteristic != nil, "The Characteristic CAN'T be nil")
        self.bluetoothManager.discoverDescriptor(characteristic!)
        self.bluetoothManager.setNotification(enable: true, forCharacteristic: self.characteristic!)
    }
    
    
    func didDisconnectPeripheral(_ peripheral: CBPeripheral) {
        print("CharacteristicController --> didDisconnectPeripheral")
    }
    
    func didDiscoverDescriptors(_ characteristic: CBCharacteristic) {
        print("CharacteristicController --> didDiscoverDescriptors")
        self.characteristic = characteristic
    }
    
    func didReadValueForCharacteristic(_ characteristic: CBCharacteristic) {
        if characteristic.uuid == CBUUID.heartRateMeasurementUUID {
            let bpm = heartRate(from: characteristic)
            onHeartRateReceived(bpm)
        }
    }
    
    func onHeartRateReceived(_ heartRate: Int) {
        print("BPM: \(heartRate)")
        self.heartBeat.text = "Heart Beats per Minute: \(heartRate)"
        UserDefaults.standard.set(heartRate, forKey: "ConnectedSensorHeartRate")
    }
    
    private func heartRate(from characteristic: CBCharacteristic) -> Int {
        guard let characteristicData = characteristic.value else { return -1 }
        let byteArray = [UInt8](characteristicData)
        let firstBitValue = byteArray[0] & 0x01
        
        if firstBitValue == 0 {
            return Int(byteArray[1])
            
        } else {
            return (Int(byteArray[1]) << 8) + Int(byteArray[2])
        }
    }
    
    @IBAction func disconnectBtnTapped(_ sender: UIButton) {
        self.bluetoothManager.disconnectPeripheral()
        self.navigationController?.popViewController(animated: true)
        self.delegate?.sensorDisconnected(withMessage: "\(self.sensorName.text ?? "") Disconnected")
    }
}
