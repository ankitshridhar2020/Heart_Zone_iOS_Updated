//
//  HistoryViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FSCalendar

class HistoryViewController: BaseViewController,  FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate  {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = "History"
        self.calendar.select(Date())
        
       // self.view.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .week

        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
        // remove left buttons (in case you added some)
        self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
    }
    
    
    @IBAction func HeartAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HistoryDetailsVc") as! HistoryDetailsVc
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    @IBAction func WalkAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HeartRateModrateVC") as! HeartRateModrateVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    @IBAction func CycleAction(_ sender: Any) {
        let objGallery = storyboard?.instantiateViewController(withIdentifier: "HeartRateCycleVC") as! HeartRateCycleVC
        self.navigationController?.pushViewController(objGallery, animated: true)
    }
    
    // MARK:- UIGestureRecognizerDelegate
   
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}

