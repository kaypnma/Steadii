//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  graphViewController.swift

//  Description/Purpose: defines view controller

//  Created by Dustin Seah on 11/3/19
//  Last Updated by Chris Keilbart on 12/01/2019
//  Worked on by  Dustin Seah, Jack Guo, and Chris Keilbart

//  Updates from Previous Commit:
/*
 - Forgot the label last time
 */

//  Known Bugs:
/*
 None
 */

//  To do:
/*
None
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
        
        // rotate the YAxis Labels
        monthlyYAxisLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        weeklyYAxisLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        //Variables used to hold the entries for the graph
        var monthlyBallEntries : [ChartDataEntry] = []
        var monthlyWordEntries : [ChartDataEntry] = []
        var weeklyBallEntries : [ChartDataEntry] = []
        var weeklyWordEntries : [ChartDataEntry] = []
        var monthlyBallTrendEntries : [ChartDataEntry] = []
        var monthlyWordTrendEntries : [ChartDataEntry] = []
        var weeklyBallTrendEntries : [ChartDataEntry] = []
        var weeklyWordTrendEntries : [ChartDataEntry] = []
        
        //Handle cases when there isn't enough data, we shouldn't create trendlines in places where there is no data
        let monthlyWordTrendLoop = GlobalAccountInfo.monthlyWordScore.count != 0 ? 2 : 0
        let monthlyBallTrendLoop = GlobalAccountInfo.monthlyBallScore.count != 0 ? 2: 0
        let weeklyWordTrendLoop = GlobalAccountInfo.weeklyWordScore.count != 0 ? 2 : 0
        let weeklyBallTrendLoop = GlobalAccountInfo.weeklyBallScore.count != 0 ? 2 : 0
        
        //If no data is present in the monthly graph for both games, the chart must therefore be totally empty
        if(GlobalAccountInfo.monthlyBallScore.count == 0 && GlobalAccountInfo.monthlyWordScore.count == 0){
            //No data
            nameTitle.text = GlobalAccountInfo.name + " has no data available"
        }
        else if(GlobalAccountInfo.weeklyBallScore.count == 0 && GlobalAccountInfo.weeklyWordScore.count == 0){
            //Monthly, but not weekly data
            nameTitle.text = GlobalAccountInfo.name + " has no weekly data available"
        }
        else{
            nameTitle.text = GlobalAccountInfo.name
        }
        
        //Monthly word entries
        for n in 0..<GlobalAccountInfo.monthlyWordX.count {
            monthlyWordEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyWordX[n], y:GlobalAccountInfo.monthlyWordScore[n]))
        }
        //Monthly ball entries
        for n in 0..<GlobalAccountInfo.monthlyBallX.count {
            monthlyBallEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyBallX[n], y:GlobalAccountInfo.monthlyBallScore[n]))
        }
        //Weekly word entries
        for n in 0..<GlobalAccountInfo.weeklyBallX.count{
            weeklyBallEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyBallX[n], y:GlobalAccountInfo.weeklyBallScore[n]))
        }
        // for weekly word
        for n in 0..<GlobalAccountInfo.weeklyWordX.count{
            weeklyWordEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyWordX[n], y:GlobalAccountInfo.weeklyWordScore[n]))
        }
        
        // for trendlines
        for n in 0..<weeklyWordTrendLoop{
            weeklyWordTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyXTrend[n], y:GlobalAccountInfo.weeklyWordYTrend[n]))
        }
        for n in 0..<weeklyBallTrendLoop{
            weeklyBallTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyXTrend[n], y:GlobalAccountInfo.weeklyBallYTrend[n]))
        }
        for n in 0..<monthlyWordTrendLoop{
            monthlyWordTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyXTrend[n], y:GlobalAccountInfo.monthlyWordYTrend[n]))
        }
        for n in 0..<monthlyBallTrendLoop{
            monthlyBallTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyXTrend[n], y:GlobalAccountInfo.monthlyBallYTrend[n]))
        }
        
        //Set monthly data
        let monthlyBallDataSet = LineChartDataSet(entries: monthlyBallEntries, label: "Ball Tilting Game")
        monthlyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let monthlyWordDataSet = LineChartDataSet(entries: monthlyWordEntries, label: "Word Association Game")
        monthlyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        //Set weekly data
        let weeklyBallDataSet = LineChartDataSet(entries: weeklyBallEntries, label: "Ball Tilting Game")
        weeklyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let weeklyWordDataSet = LineChartDataSet(entries: weeklyWordEntries, label: "Word Association Game")
        weeklyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        //Set monthly trendlines
        let monthlyBallTrendDataSet = LineChartDataSet(entries: monthlyBallTrendEntries, label: "Ball Tilting Game Trend")
        monthlyBallTrendDataSet.setCircleColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        monthlyBallTrendDataSet.setColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        
        let monthlyWordTrendDataSet = LineChartDataSet(entries: monthlyWordTrendEntries, label: "Word Association Game Trend")
        monthlyWordTrendDataSet.setCircleColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        monthlyWordTrendDataSet.setColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        
        //Set weekly trendlines
        let weeklyBallTrendDataSet = LineChartDataSet(entries: weeklyBallTrendEntries, label: "Ball Tilting Game Trend")
        weeklyBallTrendDataSet.setCircleColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        weeklyBallTrendDataSet.setColor(UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 1.00))
        
        let weeklyWordTrendDataSet = LineChartDataSet(entries: weeklyWordTrendEntries, label: "Word Association Game Trend")
        weeklyWordTrendDataSet.setCircleColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))
        weeklyWordTrendDataSet.setColor(UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.00))

        //Plot them
        let monthlyData = LineChartData(dataSets: [monthlyBallDataSet,monthlyWordDataSet,monthlyBallTrendDataSet,monthlyWordTrendDataSet])
        let weeklyData = LineChartData(dataSets: [weeklyBallDataSet,weeklyWordDataSet,weeklyBallTrendDataSet,weeklyWordTrendDataSet])
        
        monthlyData.setDrawValues(false) //No labelling
        weeklyData.setDrawValues(false)
        
        monthlyWordTrendDataSet.circleRadius = 0.0 //Do not display individual points in trendlines
        monthlyBallTrendDataSet.circleRadius = 0.0
        weeklyWordTrendDataSet.circleRadius = 0.0
        weeklyBallTrendDataSet.circleRadius = 0.0
        
        monthlyGraph.data = monthlyData //Give the graph the data
        weeklyGraph.data = weeklyData
        
        monthlyGraph.chartDescription?.text = "Performance over last month" //Description of Graphs
        weeklyGraph.chartDescription?.text = "Performance over last week"
        
        
        weeklyGraph.rightAxis.enabled = false //Disable right axis
        monthlyGraph.rightAxis.enabled = false
        
        weeklyGraph.xAxis.enabled = false //Disable x axis
        monthlyGraph.xAxis.enabled = false
        
        monthlyGraph.notifyDataSetChanged()
        weeklyGraph.notifyDataSetChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //For synchronization issues with the database
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.graphDisplay()
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }
}
