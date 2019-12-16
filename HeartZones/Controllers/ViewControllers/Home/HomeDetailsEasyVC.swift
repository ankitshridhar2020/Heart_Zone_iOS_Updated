//
//  HomeDetailsEasyVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 22/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
class HomeDetailsBarCVC: UICollectionViewCell {
    @IBOutlet private weak var barChartView: AMBarChartView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var btnStop: UIButton!
    private var barDataList = [[CGFloat]]()
    private var barColors = [UIColor]()
    private let titles = ["Blue", "Green", "Yellow", "Orange", "Red"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
        //chart
        barChartView.dataSource = self
        prepareDataList()
    }
    
    private func randomColors(alpha: CGFloat) -> UIColor {
        let r = CGFloat.random(in: 0...255) / 255.0
        let g = CGFloat.random(in: 0...255) / 255.0
        let b = CGFloat.random(in: 0...255) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    private func randomColor(r: CGFloat,g: CGFloat,b: CGFloat,alpha: CGFloat) -> UIColor {
       
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    private func randomPointType() -> AMPointType {
        let pointTypes: [AMPointType] = [.type2]
        return pointTypes[0]
    }
    
    private func prepareDataList() {
    
        let barSectionNum = 5
        let barRowNum = 1
        barDataList.removeAll()
        barColors.removeAll()
        for i in 0..<barSectionNum {
            var values = [CGFloat]()
                if i == 0 {
                    barColors.append(randomColor(r: 109/255, g: 183/255, b: 228/255, alpha: 1.0))
                }
            else if i == 1 {
                barColors.append(randomColor(r: 76/255, g: 141/255, b: 43/255, alpha: 1.0))
            }else if i == 2 {
                barColors.append(randomColor(r: 255/255, g: 178/255, b: 91/255, alpha: 1.0))
            }
            else if i == 3 {
                barColors.append(randomColor(r: 232/255, g: 119/255, b: 34/255, alpha: 1.0))
            }
           else  if i == 4 {
                barColors.append(randomColor(r: 218/255, g: 41/255, b: 28/255, alpha: 1.0))
            }
            
            values.append(CGFloat.random(in: 0...barChartView.yAxisMaxValue/CGFloat(barRowNum)))
            
            barDataList.append(values)
        }
        print(barColors)
    }
}

class HomeDetailsLineCVC: UICollectionViewCell {
    @IBOutlet private weak var lineChartView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    private var lineDataList = [[CGFloat]]()
    private var radarRowNum = 0
    private let radarAxisNum = 6
    private var lineRowNum = 0
    private let titles = ["", "", "", "", ""]
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
        //chart
      
        
        
    }
   
}

class HomeDetailsEasyVC: UIViewController, EasyVcDelegate {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    private var imgArr = [String]()
   
    //  var timer = Timer()
    var counter = 0
    var CheckBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgArr = ["A_Photographer.jpg","A_Song_of_Ice_and_Fire.jpg","Another_Rockaway_Sunset.jpg"]
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = counter
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.sliderCollectionView.bringSubviewToFront(pageView)
        counter = 0
    }
    // MARK:- Action Method
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "GotoEasyAlert") {
            let vc = segue.destination as! EasyAlertVC
            vc.EasyVcDelegate = self
        }
    }
    
    func EasyTapped(strType: String) {
        if(strType == "Resume"){
            counter = 0
            CheckBool = true
            let indexPath : NSIndexPath = NSIndexPath(row: counter, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            pageView.currentPage = counter
            
        }else if(strType == "Save"){
            let objGallery = storyboard?.instantiateViewController(withIdentifier: "HistoryDetailsVc") as! HistoryDetailsVc
            objGallery.strCheck = "Save"
            self.navigationController?.pushViewController(objGallery, animated: true)
            
        }else if(strType == "Recovery1"){
            
        }else if(strType == "Recovery2"){
            
        }else if(strType == "Discard"){
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func StopAction() {
        //self.navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "GotoEasyAlert", sender: self)
    }
//    @IBAction func StopAction(_ sender: Any) {
//
//    }
    
}
extension HomeDetailsEasyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailsBandsCVC", for: indexPath) as!  HomeDetailsBandsCVC
           
            return cell
        }else  if(indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailsBarCVC", for: indexPath) as!  HomeDetailsBarCVC
            
            return cell
        }else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailsCVC2", for: indexPath) as!  HomeDetailsCVC
               cell.btnStop.addTarget(self, action: #selector(StopAction), for: .touchUpInside)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}


extension HomeDetailsEasyVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
extension HomeDetailsEasyVC:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate where the collection view should be at the right-hand end item
        
        if(CheckBool == true){
            counter += 1
            let indexPath : NSIndexPath = NSIndexPath(row: counter, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            pageView.currentPage = counter
            if(imgArr.count-1 == counter){
                CheckBool = false
            }
            
        }else if(CheckBool == false){
            counter -= 1
            let indexPath : NSIndexPath = NSIndexPath(row: counter, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            pageView.currentPage = counter
            if(counter == 0){
                CheckBool = true
            }
        }
        
    }
}


extension HomeDetailsBarCVC: AMBarChartViewDataSource {
    func numberOfSections(in barChartView: AMBarChartView) -> Int {
        return barDataList.count
    }
    
    func barChartView(_ barChartView: AMBarChartView, numberOfRowsInSection section: Int) -> Int {
        return barDataList[section].count
    }
    
    func barChartView(_ barChartView: AMBarChartView, valueForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return barDataList[indexPath.section][indexPath.row]
    }
    
    func barChartView(_ barChartView: AMBarChartView, colorForRowAtIndexPath indexPath: IndexPath) -> UIColor {
        if indexPath.section == 0 {
           
             return UIColor.init(red: 109.0/255.0, green: 183.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        }
        else if indexPath.section == 1 {
           
             return UIColor.init(red: 76.0/255.0, green: 141.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        }else if indexPath.section == 2 {
           
             return UIColor.init(red: 255.0/255.0, green: 141.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        }
        else if indexPath.section == 3 {
            
             return UIColor.init(red: 232.0/255.0, green: 119.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
        else  {
           
             return UIColor.init(red: 218.0/255.0, green: 41.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
       
    }
    
    func barChartView(_ barChartView: AMBarChartView, titleForXlabelInSection section: Int) -> String {
        return titles[section]
    }
}


