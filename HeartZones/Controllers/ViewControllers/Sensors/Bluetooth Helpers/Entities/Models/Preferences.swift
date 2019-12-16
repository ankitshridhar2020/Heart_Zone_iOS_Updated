//
//  Preferences.swift
//  HZone
//
//  Created by Janmejay Parmar on 2019/10/28.
//  Copyright © 2019 HZone. All rights reserved.
//

import Foundation

struct Preferences: Codable {
    var needFilter: Bool
    var filter: Int
    
    init() {
        self.needFilter = false
        filter = -90
    }
}
