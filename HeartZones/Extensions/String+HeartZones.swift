//
//  String+HeartZones.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func calculateAge(withDateFormat:String) -> Int {
           let dateFormater = DateFormatter()
           dateFormater.dateFormat = withDateFormat
           let birthdayDate = dateFormater.date(from: self)
           let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
           let now = Date()
           let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
           let age = calcAge.year
           return age ?? 0
       }
    
    // MARK: To check Email is valid or not
    func isValidEmailAddress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    // MARK: To check Phone umber is valid or not
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneRegex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }
    
    func getDate(strDate:NSString) -> NSString {
        print(strDate.length)
        let substring1 = strDate.substring(with: NSMakeRange(0,6))
        return substring1 as NSString
    }
    
    func isWhatPercentOf(total: String) -> Float {
        let allQuestions: Int = Int(total)!
        let correctAnswers: Int = allQuestions - Int(self)!
        return Float((100 * correctAnswers)/allQuestions)
    }
    
    public func getVenueOpenCloseTime()-> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let todayDate = dateFormatter.date(from: self) else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "HH:mm"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
    
    public func getVenueOpenCloseDate()-> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let todayDate = dateFormatter.date(from: self) else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
    
    func getFormattedDateToShow() -> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let todayDate = dateFormatter.date(from: self) else {
            return self
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "yyyy-MM-dd h:mm a"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
    
    func getFormattedDateForOfferListDetails() -> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let todayDate = dateFormatter.date(from: self) else {
            return self
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "dd MMM yyyy HH:mm a"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
    
    func getFormattedDateForOfferList() -> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let todayDate = dateFormatter.date(from: self) else {
            return self
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "dd MMM yyyy"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
    
    func slice_string(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func isImageUrl() -> Bool {
        let imageExtensions: [String] = ["jpg", "png", "jpeg"]
        guard let extensionString: String = NSURL(fileURLWithPath: self).pathExtension else {
            return false
        }
        return imageExtensions.contains(extensionString)
    }
}
