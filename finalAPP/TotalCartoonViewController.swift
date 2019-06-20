//
//  TotalCartoonViewController.swift
//  finalAPP
//
//  Created by User20 on 2019/6/17.
//  Copyright © 2019 ouo. All rights reserved.
//

import UIKit
import Charts
import Kingfisher

class TotalCartoonViewController: UIViewController{
    
    
    
    
    var cartoons = [Cartoon]()
    var Total = 0
    
    let classification = ["girl", "boy", "questionMark"]
    var values = [0.0, 0.0, 0.0]
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var girlPersentLabel: UILabel!
    @IBOutlet weak var boyPersentLabel: UILabel!
    @IBOutlet weak var unknowPersentLabel: UILabel!
    @IBOutlet weak var imageGIF: UIImageView!
    //特別挑選的顏色
    let colors: [UIColor] = [
        UIColor(red:1.00, green:0.53, blue:0.53, alpha:1.0),
        UIColor(red:0.47, green:0.87, blue:1.00, alpha:1.0),
        UIColor(red:1.00, green:1.00, blue:0.47, alpha:1.0)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartoons = [Cartoon]()
        values = [0.0, 0.0, 0.0]
        if let cartoons = Cartoon.readCartoonsFromFile() {
            self.cartoons = cartoons
        }
        Total = 0
        var t = 0
        for cartoon in cartoons{
            Total += 1
            t = 0
            for c in classification{
                if(cartoon.gender == c){
                    values[t] += 1
                    break
                }
                t += 1
            }
        }
        totalLabel.text = "資料總數："+String(Total)
        girlPersentLabel.text = String(format: "%.1f",100*values[0]/Double(Total))+"%"
        boyPersentLabel.text = String(format: "%.1f",100*values[1]/Double(Total))+"%"
        unknowPersentLabel.text = String(format: "%.1f",100*values[2]/Double(Total))+"%"
        
        setChart()
    }
    
    func setChart() {
        
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<classification.count {
            let dataEntry = PieChartDataEntry()
            dataEntry.y = values[i]
            dataEntry.label = classification[i]
            dataEntries.append(dataEntry)
            
        }
        print(dataEntries)
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 0))
        
        pieChart.data = pieChartData
        
        /*for _ in 0..<dataPoints.count {
         let red = Double(arc4random_uniform(256))
         let green = Double(arc4random_uniform(256))
         let blue = Double(arc4random_uniform(256))
         
         let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
         colors.append(color)
         }*/
        
        pieChartDataSet.colors = colors
        
        pieChart.isUserInteractionEnabled = true
        
        let d = Description()
        d.text = ""
        pieChart.chartDescription = d
        pieChart.centerText = ""
        pieChart.holeRadiusPercent = 0
        pieChart.transparentCircleColor = UIColor.clear
        
        pieChart.legend.enabled = false
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://2.bp.blogspot.com/-y9-vEvyttkg/W6mpG0zhrhI/AAAAAAAMLOw/sI6ibNkwuaUVk3icg_mufr9z0yjg6wu2QCLcBGAs/s1600/AS0004444_05.gif")
        imageGIF.kf.setImage(with:url)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
