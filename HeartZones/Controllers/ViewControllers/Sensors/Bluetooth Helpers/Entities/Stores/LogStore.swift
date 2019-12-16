//
//  LogStore.swift
//  HZone
//
//  Created by Janmejay Parmar on 2019/10/28.
//  Copyright © 2019 HZone. All rights reserved.
//

import Foundation

class LogStore {
    
    static private var logs = [String]()
    
    class func append(_ log: String) {
        logs.append(log)
    }
    
    class func getAllLogs() -> [String] {
        return logs
    }
}
