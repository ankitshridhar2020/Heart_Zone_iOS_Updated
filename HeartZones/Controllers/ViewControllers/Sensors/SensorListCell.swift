//
//  SensorListCell.swift
//  HeartZones
//
//  Created by Apple on 22/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

protocol SensorListDelegate {
    func disconnectTapped(currentIndexPath: IndexPath)
}

class SensorListCell: UITableViewCell {
    
    @IBOutlet var nameLbl: UILabel?
    @IBOutlet var disconnectBtn: UIButton?
    var sensorListDelegate: SensorListDelegate?
    var currentIndexPath: IndexPath = IndexPath()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupSensorListCell(indexPath: IndexPath, showDisconnectBtn: Bool) {
        self.currentIndexPath = indexPath
        self.disconnectBtn?.isHidden = showDisconnectBtn ? false : true
    }
    
    @IBAction func disconnectBtnTapped(_ sender: UIButton) {
        self.sensorListDelegate?.disconnectTapped(currentIndexPath: self.currentIndexPath)
    }

}
