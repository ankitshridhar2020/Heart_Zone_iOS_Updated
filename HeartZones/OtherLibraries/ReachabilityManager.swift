//
//  ReachabilityManager.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Toaster
import ReachabilitySwift

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    // Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    // Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    // Reachibility instance for Network status monitoring
    let reachability = Reachability()!
    
    // Called whenever there is a change in NetworkReachibility Status
    // parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        self.reachabilityStatus = reachability.currentReachabilityStatus
        switch reachability.currentReachabilityStatus {
            
        case .notReachable:
            debugPrint("Network became unreachable")
            Toast(text: "Sorry! No Internet Connection.").show()
            
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
            
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
        }
    }
    
    // Starts monitoring the network availability status
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: ReachabilityChangedNotification, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }
    
}


