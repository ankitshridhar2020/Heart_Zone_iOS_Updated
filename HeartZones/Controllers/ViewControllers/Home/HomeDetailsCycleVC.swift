//
//  HomeDetailsCycleVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 17/10/19.
//  Copyright © 2019 Apple. All rights reserved.
// HomeDetailsCycleVC

import UIKit
import AAInfographics
class HomeBarGraphCVC: UICollectionViewCell {
    
    @IBOutlet weak var ViewBargraph: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
        let aaChartView = AAChartView()
        aaChartView.isClearBackgroundColor = true
        aaChartView.isSeriesHidden = true
        aaChartView.frame = CGRect(x: ViewBargraph.frame.origin.x,
                                   y: 0,
                                   width: ViewBargraph.frame.size.width + 50,
                                   height: ViewBargraph.frame.size.height)
        // aaChartView.contentHeight = viewLineChart.frame.size.height - 80
        ViewBargraph.addSubview(aaChartView)
        ViewBargraph.contentMode = .scaleAspectFit
        aaChartView.scrollEnabled = false
        aaChartView.aa_drawChartWithChartOptions(configureAAPlotBandsForChart())
        
    }
    
    private func configureAAPlotBandsForChart() -> AAOptions {
        let aaChartModel = AAChartModel()
            .title("")
            .chartType(.column)//图形类型
            .dataLabelsEnabled(false)
            .markerRadius(0)
            .categories(["Z1", "Z2", "Z3", "Z4", "Z5"])
            .legendEnabled(false)
            .series([
                AASeriesElement()
                    .name("")
                    .data([7.0, 6.9, 2.5, 14.5, 18.2])
                    .color(AAColor.white)
                    .lineWidth(2)
                ,
                ])
            .xAxisVisible(false)
        
        let aaOptions = AAOptionsConstructor.configureChartOptions(aaChartModel)
        let aaPlotBandsArr = [
            AAPlotBandsElement()
                .from(0)
                .to(4)
                .color("#00AFD7"),
            AAPlotBandsElement()
                .from(4)
                .to(8)
                .color("#ADF234"),
            AAPlotBandsElement()
                .from(8)
                .to(12)
                .color("#FFB25B"),
            AAPlotBandsElement()
                .from(12)
                .to(16)
                .color("#FAD149"),
            AAPlotBandsElement()
                .from(16)
                .to(20)
                .color("#AF231C"),
            //            AAPlotBandsElement()
            //                .from(25)
            //                .to(50)
            //                .color("#acf08f"),
        ]
        aaOptions.yAxis?.plotBands(aaPlotBandsArr)
        return aaOptions
    }
}

class HomeDetailsCycleVC: UIViewController, CycleVcDelegate {
   
    
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    private var imgArr = [String]()
    let xvalues = ["Blue", "Yellow", "Red"," "," "," "," "]
    let yvalues = [100.0, 40.0, 0.0]
    
    //   let names = ["aaa", "bbb", "ccc", "ddd"]
    //   let values = [230.0, 280.0, 450.0, 340.0]
    //  var timer = Timer()
    var counter = 0
    var CheckBool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        imgArr = ["A_Photographer.jpg","A_Song_of_Ice_and_Fire.jpg"]
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = counter
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.sliderCollectionView.bringSubviewToFront(pageView)
        counter = 0
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "GotoCycleAlert") {
            let vc = segue.destination as! CycleAlertVC
            vc.CycleVcDelegate = self
        }
    }
    
    func CycleTapped(strType: String) {
        if(strType == "Resume"){
            counter = 0
            CheckBool = true
            let indexPath : NSIndexPath = NSIndexPath(row: counter, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            pageView.currentPage = counter
            
        }else if(strType == "Save"){
            let objGallery = storyboard?.instantiateViewController(withIdentifier: "HeartRateCycleVC") as! HeartRateCycleVC
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
        self.performSegue(withIdentifier: "GotoCycleAlert", sender: self)
    }
    
}
extension HomeDetailsCycleVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailsBandsCVC", for: indexPath) as!  HomeDetailsBandsCVC
            return cell
        }else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailsBarCVC", for: indexPath) as!  HomeDetailsBarCVC
            cell.btnStop.addTarget(self, action: #selector(StopAction), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
    
}


extension HomeDetailsCycleVC: UICollectionViewDelegateFlowLayout {
    
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
extension HomeDetailsCycleVC:UIScrollViewDelegate{
    
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



