//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  graphViewController.swift

//  Description/Purpose: defines view controller

//  Created by Dustin Seah on 11/3/19
//  Last Updated by Dustin Seah on 11/29/2019
//  Worked on by  Dustin Seah, Jack Guo, and Chris Keilbart

//  Updates from Previous Commit:
/*
 - no data case done
 */

//  Known Bugs:
/*
 None
 */

//  To do:
/*
 - Intake data from firebase.
 */

//  Copyright © 2019 ii Studio. All rights reserved.

import UIKit
import Charts

class GraphViewController: UIViewController {
    @IBOutlet weak var monthlyYAxisLabel: UILabel!
    @IBOutlet weak var weeklyYAxisLabel: UILabel!
    @IBOutlet weak var monthlyGraph: LineChartView!
    @IBOutlet weak var weeklyGraph: LineChartView!
    @IBOutlet weak var nameTitle: UILabel!
    
    func graphDisplay(){
        //data will come to us as the following structure?
        
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
        
        // rotate the YAxis Labels
        monthlyYAxisLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        weeklyYAxisLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        var monthlyBallEntries : [ChartDataEntry] = []
        var monthlyWordEntries : [ChartDataEntry] = []
        var weeklyBallEntries : [ChartDataEntry] = []
        var weeklyWordEntries : [ChartDataEntry] = []
        var monthlyBallTrendEntries : [ChartDataEntry] = []
        var monthlyWordTrendEntries : [ChartDataEntry] = []
        var weeklyBallTrendEntries : [ChartDataEntry] = []
        var weeklyWordTrendEntries : [ChartDataEntry] = []
        
        /*
        // fake monthly data
        GlobalAccountInfo.monthlyBallX = [0.0,1.0,4.0,6.0,8.0,12.0,15.0,17.0,20.0,25.0,29.0]
        GlobalAccountInfo.monthlyBallScore = [15.23,15.22,17.514,19.66,16.52,16.47,19.55,20.55,14.21,16.57,19.55]
        GlobalAccountInfo.monthlyWordX = [0.0,1.0,4.0,6.0,8.0,12.0,15.0,17.0,20.0,25.0,29.0]
        GlobalAccountInfo.monthlyWordScore = [19.55,20.55,14.21,16.57,19.55,15.23,15.22,17.514,19.66,16.52,16.47]
        
        
        //fake weekly data
        GlobalAccountInfo.weeklyBallX = [0.0,1.0,4.0,6.0]
        GlobalAccountInfo.weeklyBallScore = [16.52,16.47,17.88,19.55]
        GlobalAccountInfo.weeklyWordX = [0.0,1.0,4.0,6.0]
        GlobalAccountInfo.weeklyWordScore = [19.55,14.21,16.57,19.66]
        
        
        // fake trendline data
        GlobalAccountInfo.monthlyBallYTrend = [15.23,19.55]
        GlobalAccountInfo.monthlyWordYTrend = [19.55,16.47]
        GlobalAccountInfo.weeklyBallYTrend = [16.52,19.55]
        GlobalAccountInfo.weeklyWordYTrend = [19.55,19.66]
         */
        
        /*// if the data has not been altered, i.e. no data, set everything to nil
        if(GlobalAccountInfo.monthlyBallScore == [1.0] && GlobalAccountInfo.weeklyBallScore == [1.0] && GlobalAccountInfo.monthlyWordScore == [1.0] && GlobalAccountInfo.weeklyWordScore == [1.0] && GlobalAccountInfo.monthlyBallX == [1.0] && GlobalAccountInfo.weeklyBallX == [1.0] && GlobalAccountInfo.monthlyWordX == [1.0] && GlobalAccountInfo.weeklyWordX == [1.0] && GlobalAccountInfo.monthlyBallYTrend == [1.0] && GlobalAccountInfo.weeklyBallYTrend == [1.0] && GlobalAccountInfo.monthlyWordYTrend == [1.0] && GlobalAccountInfo.weeklyWordYTrend == [1.0]){
            
            // set monthly data to empty
            GlobalAccountInfo.monthlyBallX = []
            GlobalAccountInfo.monthlyBallScore = []
            GlobalAccountInfo.monthlyWordX = []
            GlobalAccountInfo.monthlyWordScore = []
            
            
            // set weekly data to empty
            GlobalAccountInfo.weeklyBallX = []
            GlobalAccountInfo.weeklyBallScore = []
            GlobalAccountInfo.weeklyWordX = []
            GlobalAccountInfo.weeklyWordScore = []
            
            
            // set trendline data to empty
            GlobalAccountInfo.monthlyBallYTrend = []
            GlobalAccountInfo.monthlyWordYTrend = []
            GlobalAccountInfo.weeklyBallYTrend = []
            GlobalAccountInfo.weeklyWordYTrend = []
            
            trendlineStop = 0
        }*/
        
        //Handle cases when there isn't enough data
        var monthlyDataLoop = 2
        var weeklyDataLoop = 2
    //If no data is present in the monthly graph for both games, the chart must therefore be totally empty
        if(GlobalAccountInfo.monthlyBallScore.count == 0 && GlobalAccountInfo.monthlyWordScore.count == 0){
            //No data
            monthlyDataLoop = 0
            weeklyDataLoop = 0
            nameTitle.text = GlobalAccountInfo.name + " has no data available"
        }
        else if(GlobalAccountInfo.weeklyBallScore.count == 0 && GlobalAccountInfo.weeklyWordScore.count == 0){
            //Monthly, but not weekly data
            weeklyDataLoop = 0
            nameTitle.text = GlobalAccountInfo.name + " has no weekly data available"
        }
        else{
            nameTitle.text = GlobalAccountInfo.name
        }
        print(1)
        // for monthly
        for n in 0...29 {
            if GlobalAccountInfo.monthlyBallX.count <= n || GlobalAccountInfo.monthlyWordX.count <= n{
                break
            }
            monthlyBallEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyBallX[n], y:GlobalAccountInfo.monthlyBallScore[n]))
            monthlyWordEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyWordX[n], y:GlobalAccountInfo.monthlyWordScore[n]))
        }
        
        // for weekly
        for n in 0...6{
            if GlobalAccountInfo.weeklyBallX.count <= n || GlobalAccountInfo.weeklyWordX.count <= n{
                break
            }
            weeklyBallEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyBallX[n], y:GlobalAccountInfo.weeklyBallScore[n]))
            weeklyWordEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyWordX[n], y:GlobalAccountInfo.weeklyWordScore[n]))
        }
        
        // for trendlines
        for n in 0..<weeklyDataLoop{
            weeklyBallTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyXTrend[n], y:GlobalAccountInfo.weeklyBallYTrend[n]))
            weeklyWordTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyXTrend[n], y:GlobalAccountInfo.weeklyWordYTrend[n]))
        }
        for n in 0..<monthlyDataLoop{
            monthlyBallTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyXTrend[n], y:GlobalAccountInfo.monthlyBallYTrend[n]))
            monthlyWordTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyXTrend[n], y:GlobalAccountInfo.monthlyWordYTrend[n]))
        }
        
        // set monthly data
        let monthlyBallDataSet = LineChartDataSet(entries: monthlyBallEntries, label: "Ball Tilting Game")
        monthlyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let monthlyWordDataSet = LineChartDataSet(entries: monthlyWordEntries, label: "Word Association Game")
        monthlyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        
        // set weekly data
        let weeklyBallDataSet = LineChartDataSet(entries: weeklyBallEntries, label: "Ball Tilting Game")
        weeklyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let weeklyWordDataSet = LineChartDataSet(entries: weeklyWordEntries, label: "Word Association Game")
        weeklyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        
        // set trendlines
        let monthlyBallTrendDataSet = LineChartDataSet(entries: monthlyBallTrendEntries, label: "Ball Tilting Game Trend")
        monthlyBallTrendDataSet.setCircleColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        monthlyBallTrendDataSet.setColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        
        let monthlyWordTrendDataSet = LineChartDataSet(entries: monthlyWordTrendEntries, label: "Word Association Game Trend")
        monthlyWordTrendDataSet.setCircleColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        monthlyWordTrendDataSet.setColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        
        
        let weeklyBallTrendDataSet = LineChartDataSet(entries: weeklyBallTrendEntries, label: "Ball Tilting Game Trend")
        weeklyBallTrendDataSet.setCircleColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        weeklyBallTrendDataSet.setColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        
        let weeklyWordTrendDataSet = LineChartDataSet(entries: weeklyWordTrendEntries, label: "Word Association Game Trend")
        weeklyWordTrendDataSet.setCircleColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        weeklyWordTrendDataSet.setColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        
        //weeklyWordTrendDataSet.valueFont = (name: "Verdana", size: 14.0)
        // doesn't work because "no such module UIFont"
        
        let monthlyData = LineChartData(dataSets: [monthlyBallDataSet,monthlyWordDataSet,monthlyBallTrendDataSet,monthlyWordTrendDataSet])
        let weeklyData = LineChartData(dataSets: [weeklyBallDataSet,weeklyWordDataSet,weeklyBallTrendDataSet,weeklyWordTrendDataSet])
        
        monthlyData.setDrawValues(false) // don't label points
        weeklyData.setDrawValues(false)
        
        monthlyWordTrendDataSet.circleRadius = 0.0 // no individual points for plotting for trendline
        monthlyBallTrendDataSet.circleRadius = 0.0
        weeklyWordTrendDataSet.circleRadius = 0.0
        weeklyBallTrendDataSet.circleRadius = 0.0
        
        monthlyGraph.data = monthlyData // feed data into object
        weeklyGraph.data = weeklyData
        
        monthlyGraph.chartDescription?.text = "Performance over last month" //Description of Graphs
        weeklyGraph.chartDescription?.text = "Performance over last week"
        
        
        weeklyGraph.rightAxis.enabled = false // disable the right axis
        monthlyGraph.rightAxis.enabled = false
        
        weeklyGraph.xAxis.enabled = false // disable the x axis
        monthlyGraph.xAxis.enabled = false
        
        monthlyGraph.notifyDataSetChanged()
        weeklyGraph.notifyDataSetChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.graphDisplay()
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }
}
