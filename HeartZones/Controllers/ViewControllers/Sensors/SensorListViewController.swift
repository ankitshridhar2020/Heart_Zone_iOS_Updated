//
//  SensorListViewController.swift
//  HeartZones
//
//  Created by Apple on 22/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Toaster
import CoreBluetooth

class SensorListViewController: BaseViewController {
    
    @IBOutlet var sensorListTbl: UITableView? {
        didSet{
            self.sensorListTbl?.tableFooterView = UIView()
        }
    }
    var sensorType: String = String()
    @IBOutlet var sensorTypeLbl: UILabel?
    
    //BLE variables
    var centralManager: CBCentralManager!
    let heartRateServiceCBUUID = CBUUID(string: "0x180D")
    var heartRatePeripheral: CBPeripheral?
    var peripherals:[CBPeripheral] = []
    var connectedPeripherals: [CBPeripheral] = []

    // MARK:- view controller life cycle methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.global())
        heartRatePeripheral?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
    }
    
    // MARK: - Common methods
    
    func configureComponentsLayout() {
        self.showLeftIconOnNavigationBar()
        self.navigationController?.navigationBar.topItem?.title = "Sensors"
        self.sensorTypeLbl?.text = self.sensorType
    }
    
    // MARK: - ACTION methods
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableView Delegate/DataSource methods

extension SensorListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return self.connectedPeripherals.count != 0 ? 45 : 0
        }else {
            return self.peripherals.count != 0 ? 45 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.connectedPeripherals.count : self.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let bgView = UIView()
            bgView.backgroundColor = .groupTableViewBackground
            let headingLbl: UILabel = UILabel(frame: CGRect(x: 30, y: 0, width: 100, height: 50.0))
            headingLbl.text = "Paired Devices"
            headingLbl.textColor = .darkGray
            headingLbl.font = UIFont.normalFontOfSize(size: 13.0)
            bgView.addSubview(headingLbl)
            return bgView
        }else {
            let bgView = UIView()
            bgView.backgroundColor = .groupTableViewBackground
            bgView.backgroundColor = .groupTableViewBackground
            let headingLbl: UILabel = UILabel(frame: CGRect(x: 30, y: 0, width: 125, height: 50.0))
            headingLbl.text = "Available Devices"
            headingLbl.textColor = .darkGray
            headingLbl.font = UIFont.normalFontOfSize(size: 13.0)
            bgView.addSubview(headingLbl)
            return bgView
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let sensorListCell = tableView.dequeueReusableCell(withIdentifier: "sensorList", for: indexPath) as! SensorListCell
            let peripheral = self.connectedPeripherals[indexPath.row]
            sensorListCell.nameLbl?.text = peripheral.name
            sensorListCell.sensorListDelegate = self
            sensorListCell.setupSensorListCell(indexPath: indexPath, showDisconnectBtn: true)
            return sensorListCell
        }else {
            let sensorListCell = tableView.dequeueReusableCell(withIdentifier: "sensorList", for: indexPath) as! SensorListCell
            let peripheral = self.peripherals[indexPath.row]
            sensorListCell.nameLbl?.text = peripheral.name
            sensorListCell.sensorListDelegate = self
            sensorListCell.setupSensorListCell(indexPath: indexPath, showDisconnectBtn: false)
            return sensorListCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let peripheral = self.peripherals[indexPath.row]
            centralManager.connect(peripheral, options: [:])
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - CBCentralManagerDelegate

extension SensorListViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: [heartRateServiceCBUUID])
        @unknown default: break
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if (!peripherals.contains(peripheral)){
            peripherals.append(peripheral)
        }
        DispatchQueue.main.async {
            self.sensorListTbl?.reloadData()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        peripheral.delegate = self
        if (!connectedPeripherals.contains(peripheral)){
            connectedPeripherals.append(peripheral)
        }
        DispatchQueue.main.async {
            self.sensorListTbl?.reloadData()
        }
        //heartRatePeripheral!.discoverServices([heartRateServiceCBUUID])
    }
    
}

// MARK: - CBPeripheralDelegate

extension SensorListViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            print(service)
            print(service.characteristics ?? "characteristics are nil")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print(characteristic)
            if characteristic.properties.contains(.read) {
                print("\(characteristic.uuid): properties contains .read")
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        
    }
    
    private func heartRate(from characteristic: CBCharacteristic) -> Int {
        guard let characteristicData = characteristic.value else { return -1 }
        let byteArray = [UInt8](characteristicData)
        
        let firstBitValue = byteArray[0] & 0x01
        if firstBitValue == 0 {
            // Heart Rate Value Format is in the 2nd byte
            return Int(byteArray[1])
        } else {
            // Heart Rate Value Format is in the 2nd and 3rd bytes
            return (Int(byteArray[1]) << 8) + Int(byteArray[2])
        }
    }
    
}

// MARK: - SensorListDelegate

extension SensorListViewController: SensorListDelegate {
    
    func disconnectTapped(currentIndexPath: IndexPath) {
        print(currentIndexPath)
        centralManager.cancelPeripheralConnection(self.connectedPeripherals[currentIndexPath.row])
        self.sensorListTbl?.reloadData()
    }
    
}
