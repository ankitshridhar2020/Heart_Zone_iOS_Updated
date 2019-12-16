//
//  SensorsViewController.swift
//  HeartZones
//
//  Created by Apple on 21/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class SensorsViewController: BaseViewController {
    
    @IBOutlet var categoryTbl: UITableView? {
        didSet {
            self.categoryTbl?.tableFooterView = UIView()
        }
    }

    // MARK:- view controller life cycle methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = "Sensors"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
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

}

// MARK: - UITableView Delegate/DataSource methods

extension SensorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return "Available Sensors"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 17)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.categoryTbl!, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! CategoryCell
        switch indexPath.row {
        case 0:
            categoryCell.nameLbl?.text = "Heart Rate"
            categoryCell.stateLbl?.text = "Not set up"
            break
        case 1:
            categoryCell.nameLbl?.text = "Cycling Speed/Cadence"
            categoryCell.stateLbl?.text = "Not set up"
            break
        case 2:
            categoryCell.nameLbl?.text = "Cycling Power"
            categoryCell.stateLbl?.text = "Not set up"
            break
        default:
            categoryCell.nameLbl?.text = "Step Tracking"
            categoryCell.stateLbl?.text = "Not set up"
        }
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sensorListVcObj: SensorListViewController = self.storyboard?.instantiateViewController(withIdentifier: "SensorListVc") as! SensorListViewController
        let sensorListVcObj: BluetoothVC = UIStoryboard.init(name: "Sensors", bundle: nil).instantiateViewController(withIdentifier: "BluetoothVC") as! BluetoothVC

        
//        switch indexPath.row {
//        case 0:
//            sensorListVcObj.sensorType = "Heart Rate"
//            break
//        case 1:
//            sensorListVcObj.sensorType = "Cycling Speed/Cadence"
//            break
//        case 2:
//            sensorListVcObj.sensorType = "Cycling Power"
//            break
//        default:
//            sensorListVcObj.sensorType = "Step Tracking"
//        }
        self.navigationController?.pushViewController(sensorListVcObj, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
