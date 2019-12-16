//
//  Date+HeartZones.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getDayOfWeek(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let todayDate = formatter.date(from: today) {
            formatter.dateStyle = DateFormatter.Style.full
            let strFormatedDate = formatter.string(from: todayDate)
            return strFormatedDate
        } else {
            return ""
        }
    }
    
    public func getCurrentDate()-> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: date as Date) as String
        return currentDate
    }
    
    public func getFormattedDate()-> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd-MMM-yyyy"
        let currentDate = formatter.string(from: self as Date) as String
        return currentDate
    }
    
    public func getdDateForFilterPageApis()-> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: self as Date) as String
        return currentDate
    }
    
    func getDateForByIssueHeader(strDate: String)->String? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formatter_1 = DateFormatter()
        formatter_1.dateStyle = .short
        formatter_1.dateFormat = "dd MMMM yyyy"
        
        if let todayDate = formatter.date(from: strDate) {
            let choosenDate = formatter_1.string(from: todayDate) as String
            return choosenDate
        }else {
            let currentDate = formatter_1.string(from: self as Date) as String
            return currentDate
        }
    }
    
    func getDateForNotes(strDate: String)->String? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formatter_1 = DateFormatter()
        formatter_1.dateStyle = .short
        formatter_1.dateFormat = "dd MMM, yyyy"
        
        if let todayDate = formatter.date(from: strDate) {
            let choosenDate = formatter_1.string(from: todayDate) as String
            return choosenDate
        }else {
            let currentDate = formatter_1.string(from: self as Date) as String
            return currentDate
        }
    }
    
    
    public func getCurrentSentimentDate()-> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "MMMM dd, yyyy"
        let currentDate = formatter.string(from: date as Date) as String
        return currentDate
    }
    
    
}
