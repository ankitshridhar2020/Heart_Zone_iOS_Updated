//
//  NewBluetoothVC.swift
//  SmartSearching
//
//  Created by Janmejay Parmar on 16/10/19.
//  Copyright © 2019 Atto Infotech. All rights reserved.
//

import UIKit
import CoreBluetooth
import QuartzCore

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

class BluetoothVC: UIViewController, UITableViewDataSource, UITableViewDelegate, BluetoothDelegate, didDisconnectSensorDelegate {
    
    //outlets
    @IBOutlet weak var devicesTable: UITableView!
    
    
    //properties
    fileprivate class PeripheralInfos: Equatable, Hashable {
        let peripheral: CBPeripheral
        var RSSI: Int = 0
        var advertisementData: [String: Any] = [:]
        var lastUpdatedTimeInterval: TimeInterval
        
        init(_ peripheral: CBPeripheral) {
            self.peripheral = peripheral
            self.lastUpdatedTimeInterval = Date().timeIntervalSince1970
        }
        
        static func == (lhs: PeripheralInfos, rhs: PeripheralInfos) -> Bool {
            return lhs.peripheral.isEqual(rhs.peripheral)
        }
        
        var hashValue: Int {
            return peripheral.hash
        }
    }
    
    let bluetoothManager = BluetoothManager.getInstance()
    var connectingView: ConnectingView?
    fileprivate var nearbyPeripheralInfos: [PeripheralInfos] = []
    var cachedVirtualPeripherals: [VirtualPeripheral] {
        return VirtualPeripheralStore.shared.cachedVirtualPeripheral
    }
    var preferences: Preferences? {
        return PreferencesStore.shared.preferences
    }
    var selectedVirtualPeriperalIndex: Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heart Zones Training"
        
        self.devicesTable.register(UITableViewCell.self, forCellReuseIdentifier: "SearchingCell")
        self.devicesTable.tableFooterView = UIView.init(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.toolbarItems = self.navigationController?.toolbar.items
        nearbyPeripheralInfos.removeAll()
        if bluetoothManager.connectedPeripheral != nil {
            bluetoothManager.disconnectPeripheral()
            
        }
        bluetoothManager.delegate = self
        devicesTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.nearbyPeripheralInfos.count == 0 {
            let bgView = UIView()
            let emptyLabel = UILabel()
            emptyLabel.frame = CGRect(x: 12, y: -100, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height)
            emptyLabel.text = "No sensors found in range. Make sure the bluetooth is active."
            emptyLabel.textColor = UIColor.lightGray
            emptyLabel.numberOfLines = 3
            emptyLabel.textAlignment = .center
            bgView.addSubview(emptyLabel)
            tableView.backgroundView = bgView
            return 0
            
        } else {
            tableView.backgroundView = nil
            return self.nearbyPeripheralInfos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard nearbyPeripheralInfos.count != 0 || indexPath.row != 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchingCell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = "Searching for peripherals..."
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .thin)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyPeripheralCell") as! NearbyPeripheralCell
        let peripheralInfo = nearbyPeripheralInfos[indexPath.row]
        let peripheral = peripheralInfo.peripheral
        
        cell.sensorName.text = peripheral.name == nil || peripheral.name == ""  ? "Unnamed" : peripheral.name
        cell.deviceID.text = peripheral.identifier.uuidString 
        
        let RSSI = peripheralInfo.RSSI
        if RSSI == 127 {
            cell.signalStrength.text = "---"
            cell.signalStrength.alpha = 0.4
            cell.signalStrength.alpha = 0.4
            
        }  else {
            if (0...10).contains(abs(RSSI)) {
                cell.signalStrength.text = "97%%"
                
            } else if (11...20).contains(abs(RSSI)) {
                cell.signalStrength.text = "95%"
                
            } else if (21...30).contains(abs(RSSI)) {
                cell.signalStrength.text = "93%"
                
            } else if (31...40).contains(abs(RSSI)) {
                cell.signalStrength.text = "90%"
                
            } else if (41...50).contains(abs(RSSI)) {
                cell.signalStrength.text = "88%"
                
            } else if (51...55).contains(abs(RSSI)) {
                cell.signalStrength.text = "85%"
                
            } else if (56...62).contains(abs(RSSI)) {
                cell.signalStrength.text = "83%"
                
            } else if (63...65).contains(abs(RSSI)) {
                cell.signalStrength.text = "80%"
                
            } else if (66...68).contains(abs(RSSI)) {
                cell.signalStrength.text = "75%"
                
            } else if (69...74).contains(abs(RSSI)) {
                cell.signalStrength.text = "73%"
                
            } else if (75...79).contains(abs(RSSI)) {
                cell.signalStrength.text = "70%"
                
            } else if (80...83).contains(abs(RSSI)) {
                cell.signalStrength.text = "65%"
                
            } else if (84...87).contains(abs(RSSI)) {
                cell.signalStrength.text = "60%"
                
            } else if (88...91).contains(abs(RSSI)) {
                cell.signalStrength.text = "55%"
                
            } else if (92...93).contains(abs(RSSI)) {
                cell.signalStrength.text = "50%"
                
            } else if (94...95).contains(abs(RSSI)) {
                cell.signalStrength.text = "45%"
                
            } else if (96...97).contains(abs(RSSI)) {
                cell.signalStrength.text = "40%"
                
            } else if (98...99).contains(abs(RSSI)) {
                cell.signalStrength.text = "35%"
                
            } else if (100...110).contains(abs(RSSI)) {
                cell.signalStrength.text = "30%"
                
            } else if (111...120).contains(abs(RSSI)) {
                cell.signalStrength.text = "20%"
                
            } else if (121...130).contains(abs(RSSI)) {
                cell.signalStrength.text = "10%"
                
            } else if (131...135).contains(abs(RSSI)) {
                cell.signalStrength.text = "5%"
                
            } else {
                cell.signalStrength.text = "0%"
                
            }
            
            cell.sensorName.alpha = 1.0
        }
        
        return cell
    }
    
    func calculateNewDistance(txCalibratedPower: Int, rssi: Int) -> Double {
        if rssi == 0 {
            return -1
        }
        let ratio = Double(exactly:rssi)!/Double(txCalibratedPower)
        if ratio < 1.0 {
            return pow(10.0, ratio)
        } else {
            let accuracy = 0.89976 * pow(ratio, 7.7095) + 0.111
            return accuracy
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = nearbyPeripheralInfos[indexPath.row].peripheral
        connectingView = ConnectingView.showConnectingView()
        connectingView?.tipNameLbl.text = peripheral.name
        bluetoothManager.connectPeripheral(peripheral)
        bluetoothManager.stopScanPeripheral()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        headerView.backgroundColor = UIColor.lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 200, height: 30))
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .darkGray
        
        titleLabel.text = "Heartzone active sensors"
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func didDiscoverPeripheral(_ peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber) {
        let peripheralInfo = PeripheralInfos(peripheral)
        if !nearbyPeripheralInfos.contains(peripheralInfo) {
            if let preference = preferences, preference.needFilter {
                if RSSI.intValue != 127, RSSI.intValue > preference.filter {
                    peripheralInfo.RSSI = RSSI.intValue
                    peripheralInfo.advertisementData = advertisementData
                    nearbyPeripheralInfos.append(peripheralInfo)
                    LogStore.append("Discovered nearby peripheral: \(peripheral.name ?? "(null)") (RSSI: \(RSSI.intValue))")
                }
            } else {
                peripheralInfo.RSSI = RSSI.intValue
                peripheralInfo.advertisementData = advertisementData
                nearbyPeripheralInfos.append(peripheralInfo)
                LogStore.append("Discovered nearby peripheral: \(peripheral.name ?? "(null)")) (RSSI: \(RSSI.intValue))")
            }
        } else {
            guard let index = nearbyPeripheralInfos.firstIndex(of: peripheralInfo) else {
                return
            }
            
            let originPeripheralInfo = nearbyPeripheralInfos[index]
            let nowTimeInterval = Date().timeIntervalSince1970
            
            // If the last update within one second, then ignore it
            guard nowTimeInterval - originPeripheralInfo.lastUpdatedTimeInterval >= 1.0 else {
                return
            }
            
            originPeripheralInfo.lastUpdatedTimeInterval = nowTimeInterval
            originPeripheralInfo.RSSI = RSSI.intValue
            originPeripheralInfo.advertisementData = advertisementData
        }
        devicesTable.reloadData()
    }
    
    
    func didUpdateState(_ state: CBCentralManagerState) {
        print("MainController --> didUpdateState:\(state)")
        switch state {
        case .resetting:
            print("MainController --> State : Resetting")
            LogStore.append("Bluetooth State: Resetting")
            
        case .poweredOn:
            LogStore.append("Bluetooth State: Powered On")
            bluetoothManager.startScanPeripheral()
            UnavailableView.hideUnavailableView()
            
        case .poweredOff:
            print(" MainController -->State : Powered Off")
            LogStore.append("Bluetooth State: Powered Off")
            fallthrough
            
        case .unauthorized:
            print("MainController --> State : Unauthorized")
            LogStore.append("Bluetooth State: Unauthorized")
            fallthrough
            
        case .unknown:
            print("MainController --> State : Unknown")
            LogStore.append("Bluetooth State: Unknown")
            fallthrough
            
        case .unsupported:
            print("MainController --> State : Unsupported")
            LogStore.append("Bluetooth State: Unsupported")
            bluetoothManager.stopScanPeripheral()
            bluetoothManager.disconnectPeripheral()
            ConnectingView.hideConnectingView()
            UnavailableView.showUnavailableView()
            
        @unknown default:
            print("MainController --> State : default")
        }
    }
    
    func didConnectedPeripheral(_ connectedPeripheral: CBPeripheral) {
        print("MainController --> didConnectedPeripheral")
        connectingView?.tipLbl.text = "Sensor connected."
    }
    
    func sensorDisconnected(withMessage: String) {
        self.present(AlertUtil.showAlert(msg: withMessage, withTitle: ""), animated: true, completion: nil)
    }
    
    func didDiscoverServices(_ peripheral: CBPeripheral) {
        ConnectingView.hideConnectingView()
        let dest = UIStoryboard.init(name: "Sensors", bundle: nil).instantiateViewController(withIdentifier: "HeartBeatVC") as! HeartBeatVC
        dest.delegate = self
        self.navigationController?.pushViewController(dest, animated: true)
    }
    
    func didFailedToInterrogate(_ peripheral: CBPeripheral) {
        ConnectingView.hideConnectingView()
        AlertUtil.showCancelAlert("Connection Alert", message: "The perapheral disconnected while being interrogated.", cancelTitle: "Dismiss", viewController: self)
    }
    
    //MARK:- Action Method
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
