//
//  ZonesMethodologyVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 04/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ZoneMethodologyTVC: UITableViewCell {
    
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var btnConfigure: UIButton!
    @IBOutlet weak var lbl: UILabel!
}

class ZonesMethodologyVC: UIViewController {

    @IBOutlet weak var tblView: UITableView! {
        didSet {
            self.tblView?.tableFooterView = UIView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    // MARK: - Action Method
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func ConfifureAction(sender: UIButton){
        if sender.tag == 0 {
            let sensorListVcObj: ZoningHeartRateVC = self.storyboard?.instantiateViewController(withIdentifier: "ZoningHeartRateVC") as! ZoningHeartRateVC
            sensorListVcObj.sensorType = "Zoning Heart Rate"
            self.navigationController?.pushViewController(sensorListVcObj, animated: true)
            
        } else if sender.tag == 1 {
            let sensorListVcObj: ZoningMaxPeakVC = self.storyboard?.instantiateViewController(withIdentifier: "ZoningMaxPeakVC") as! ZoningMaxPeakVC
            sensorListVcObj.sensorType = "Max/peak Heart Rate"
            self.navigationController?.pushViewController(sensorListVcObj, animated: true)
            
        } else {
            let sensorListVcObj: ZoningThresholdVC = self.storyboard?.instantiateViewController(withIdentifier: "ZoningThresholdVC") as! ZoningThresholdVC
            sensorListVcObj.sensorType = "Threshold Heart Rate"
            self.navigationController?.pushViewController(sensorListVcObj, animated: true)
        }
    }
        
        
    @objc func radioBtnTapped(sender: UIButton){
        UserDefaults.standard.set(sender.tag, forKey: GlobalRoles.selectedZone)
        self.tblView.reloadData()
    }
    
}

// MARK: - UITableView Delegate/DataSource methods

extension ZonesMethodologyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Zour Zone Methodology"
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 15)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tblView!, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "ZoneMethodologyTVC", for: indexPath) as! ZoneMethodologyTVC
       
          //  categoryCell.btnRadio.setImage(UIImage.init(named: "radio_red"), for: .normal)
       
            // categoryCell.btnRadio.setImage(UIImage.init(named: "radio_grey"), for: .normal)
       
        switch indexPath.row {
        case 0:
            categoryCell.lbl?.text = "Zoning Heart Rate"
           
            break
        case 1:
            categoryCell.lbl?.text = "Max/peak Heart Rate"
           
            break
        case 2:
            categoryCell.lbl?.text = "Threshold Heart Rate"
           
            break
        default:
            categoryCell.lbl?.text = ""
            
        }
        
        
        categoryCell.btnConfigure.tag = indexPath.row
        categoryCell.btnRadio.tag = indexPath.row
        categoryCell.btnConfigure.addTarget(self, action: #selector(ConfifureAction(sender:)), for: .touchUpInside)
        categoryCell.btnRadio.addTarget(self, action: #selector(radioBtnTapped), for: .touchUpInside)
        categoryCell.selectionStyle = .none
        
        
        let selectedZone = UserDefaults.standard.value(forKey: GlobalRoles.selectedZone) as? Int ?? 0
        if selectedZone == indexPath.row {
            categoryCell.btnRadio.setImage(UIImage(named: "checked"), for: .normal)
            
        } else {
            categoryCell.btnRadio.setImage(UIImage(named: "unchecked"), for: .normal)

        }
        
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
