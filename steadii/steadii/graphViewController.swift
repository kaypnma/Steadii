//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  graphViewController.swift

//  Description/Purpose: defines view controller

//  Created by Dustin Seah on 11/3/19
//  Last Updated by Dustin Seah on 11/23/2019
//  Worked on by Kay Arellano, Dustin Seah, Jack Guo, Denyse Tran, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Still faking data
 -  Normalized the function names
 -  Lines have different colours
 -  Made more modular for intaking data
 -  Took out right axis labels
 -  Took out in graph labels
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
        // Not sure of the form the data will be when taking from firebase , I assumed as a dictionary
        // so, data will come to us as the following structure?
        
        // [Ball Game Performances]
        // [Date]   [Score/Time]
        // Nov 12   25.345
        // Nov 24   22.556
        // Nov 25   15.842
        // ..
        
        // [Word Game Performances]
        // Nov 17   13.257
        // Nov 20   23.233
        // Nov 23   26.554
        // ..
        
        // To do:
        // retieve data.
        
        // split data into past week and month.
        // is there a date type we can use?
        
        // assuming the data have been processed into the following arrays
        
        // FAKE DATA
        //let processedMonthlyBallxData = [0.0,12.0,13.0]
        //let processedMonthlyBallyData = [25.345,22.556,15.842]
        
        //let processedMonthlyWordxData = [0,3,6]
        //let processedMonthlyWordyData = [13.257,23.233,26.554]
        
        //let processedWeeklyBallxData = [0,1]
        //let processedWeeklyBallyData = [22.556,15.842]
        
        //let processedWeeklyWordxData = [0,3]
        //let processedWeeklyWordyData = [23.233,26.554]
        
        
        // fake entries
        let monthlyBallEntry1 = ChartDataEntry(x: 1.0/*processedMonthlyBallxData*/, y: 2.0/*processedMonthlyBallyData*/)
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
        
        monthlyData.setDrawValues(false) // don't label points
        weeklyData.setDrawValues(false)
        
        monthlyGraph.data = monthlyData // feed data into object
        weeklyGraph.data = weeklyData
        
        monthlyGraph.chartDescription?.text = "Monthly Trend" //Description of Graphs
        weeklyGraph.chartDescription?.text = "Weekly Trend"
        
        
        weeklyGraph.rightAxis.enabled = false // disable the right axis
        monthlyGraph.rightAxis.enabled = false
        
        monthlyGraph.notifyDataSetChanged()
        weeklyGraph.notifyDataSetChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        graphDisplay()
    }
}
