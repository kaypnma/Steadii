//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  ViewController.swift

//  Description/Purpose: defines view controller

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 11/21/2019
//  Worked on by Kay Arellano, Dustin Seah, Jack Guo, Denyse Tran, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Still faking data
 -  Normalized the function names
 -  Lines have different colours
 -  Made more modular for intaking data
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
   - Intake data from firebase and individualize the graph view.
        -> as of now, any name we tap goes into "Denyse's statistics"
*/

//  Copyright © 2019 ii Studio. All rights reserved.

import UIKit
import Charts
class GraphViewController: UIViewController {
    @IBOutlet weak var monthlyGraph: LineChartView!
    @IBOutlet weak var weeklyGraph: LineChartView!
    
    func graphDisplay(){
        // fake entries
        let monthlyBallEntry1 = ChartDataEntry(x: 1.0, y: 2.0)
        let monthlyBallEntry2 = ChartDataEntry(x: 2.0, y: 4.0)
        let monthlyBallEntry3 = ChartDataEntry(x: 3.0, y: 8.0)
        let weeklyBallEntry1 = ChartDataEntry(x: 1.0, y: 3.0)
        let weeklyBallEntry2 = ChartDataEntry(x: 2.0, y: 9.0)
        let weeklyBallEntry3 = ChartDataEntry(x: 3.0, y: 18.0)
        let monthlyWordEntry1 = ChartDataEntry(x: 1.0, y: 3.0)
        let monthlyWordEntry2 = ChartDataEntry(x: 2.0, y: 9.0)
        let monthlyWordEntry3 = ChartDataEntry(x: 3.0, y: 18.0)
        let weeklyWordEntry1 = ChartDataEntry(x: 1.0, y: 2.0)
        let weeklyWordEntry2 = ChartDataEntry(x: 2.0, y: 4.0)
        let weeklyWordEntry3 = ChartDataEntry(x: 3.0, y: 8.0)
        
        // set monthly data
        let monthlyBallDataSet = LineChartDataSet(entries: [monthlyBallEntry1, monthlyBallEntry2, monthlyBallEntry3], label: "Ball Tilting Game")
        monthlyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        let monthlyWordDataSet = LineChartDataSet(entries: [monthlyWordEntry1, monthlyWordEntry2, monthlyWordEntry3], label: "Word Association Game")
        monthlyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        let monthlyData = LineChartData(dataSets: [monthlyBallDataSet,monthlyWordDataSet])
        
        // set weekly data
        let weeklyBallDataSet = LineChartDataSet(entries: [weeklyBallEntry1, weeklyBallEntry2, weeklyBallEntry3], label: "Ball Tilting Game")
        weeklyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        let weeklyWordDataSet = LineChartDataSet(entries: [weeklyWordEntry1, weeklyWordEntry2, weeklyWordEntry3], label: "Word Association Game")
        weeklyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        let weeklyData = LineChartData(dataSets: [weeklyBallDataSet,weeklyWordDataSet])
        
        monthlyGraph.data = monthlyData
        weeklyGraph.data = weeklyData
        
        monthlyGraph.chartDescription?.text = "Monthly Trend"
        weeklyGraph.chartDescription?.text = "Weekly Trend"
        
        monthlyGraph.notifyDataSetChanged()
        weeklyGraph.notifyDataSetChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        graphDisplay()
    }
}
