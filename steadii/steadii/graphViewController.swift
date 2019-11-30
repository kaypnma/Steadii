//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  graphViewController.swift

//  Description/Purpose: defines view controller

//  Created by Dustin Seah on 11/3/19
//  Last Updated by Dustin Seah on 11/28/2019
//  Worked on by  Dustin Seah, Jack Guo, and Chris Keilbart

//  Updates from Previous Commit:
/*
 - faked data in arrays instead
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
    @IBOutlet weak var monthlyGraph: LineChartView!
    @IBOutlet weak var weeklyGraph: LineChartView!
    @IBOutlet weak var nameTitle: UILabel!
    
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
        
        
        
        var monthlyBallEntries : [ChartDataEntry] = []
        var monthlyWordEntries : [ChartDataEntry] = []
        var weeklyBallEntries : [ChartDataEntry] = []
        var weeklyWordEntries : [ChartDataEntry] = []
        var monthlyBallTrendEntries : [ChartDataEntry] = []
        var monthlyWordTrendEntries : [ChartDataEntry] = []
        var weeklyBallTrendEntries : [ChartDataEntry] = []
        var weeklyWordTrendEntries : [ChartDataEntry] = []
        
        
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
        
        GlobalAccountInfo.name = "Test Name"
        nameTitle.text = GlobalAccountInfo.name
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
        for n in 0...1{
            
            monthlyBallTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyXTrend[n], y:GlobalAccountInfo.monthlyBallYTrend[n]))
            monthlyWordTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.monthlyXTrend[n], y:GlobalAccountInfo.monthlyWordYTrend[n]))
            weeklyBallTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyXTrend[n], y:GlobalAccountInfo.weeklyBallYTrend[n]))
            weeklyWordTrendEntries.append(ChartDataEntry(x: GlobalAccountInfo.weeklyXTrend[n], y:GlobalAccountInfo.weeklyWordYTrend[n]))
        }
        
        
        // fake entries
        /*
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
        */
        
        // set monthly data
        let monthlyBallDataSet = LineChartDataSet(entries: monthlyBallEntries/*[monthlyBallEntry1, monthlyBallEntry2, monthlyBallEntry3]*/, label: "Ball Tilting Game")
        monthlyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let monthlyWordDataSet = LineChartDataSet(entries: monthlyWordEntries/*[monthlyWordEntry1, monthlyWordEntry2, monthlyWordEntry3]*/, label: "Word Association Game")
        monthlyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        
        // set weekly data
        let weeklyBallDataSet = LineChartDataSet(entries: weeklyBallEntries/*[weeklyBallEntry1, weeklyBallEntry2, weeklyBallEntry3]*/, label: "Ball Tilting Game")
        weeklyBallDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyBallDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let weeklyWordDataSet = LineChartDataSet(entries: weeklyWordEntries/*[weeklyWordEntry1, weeklyWordEntry2, weeklyWordEntry3]*/, label: "Word Association Game")
        weeklyWordDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyWordDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        
        // set trendlines
        let monthlyBallTrendDataSet = LineChartDataSet(entries: monthlyBallTrendEntries/*[monthlyBallEntry1, monthlyBallEntry2, monthlyBallEntry3]*/, label: "Ball Tilting Game Trend")
        monthlyBallTrendDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyBallTrendDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let monthlyWordTrendDataSet = LineChartDataSet(entries: monthlyWordTrendEntries/*[monthlyWordEntry1, monthlyWordEntry2, monthlyWordEntry3]*/, label: "Word Association Game Trend")
        monthlyWordTrendDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        monthlyWordTrendDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        
        let weeklyBallTrendDataSet = LineChartDataSet(entries: weeklyBallTrendEntries/*[weeklyBallEntry1, weeklyBallEntry2, weeklyBallEntry3]*/, label: "Ball Tilting Game Trend")
        weeklyBallTrendDataSet.setCircleColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyBallTrendDataSet.setColor(UIColor(red: 0.511, green: 0.686, blue: 0.980, alpha: 1.00))
        
        let weeklyWordTrendDataSet = LineChartDataSet(entries: weeklyWordTrendEntries/*[weeklyWordEntry1, weeklyWordEntry2, weeklyWordEntry3]*/, label: "Word Association Game Trend")
        weeklyWordTrendDataSet.setCircleColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        weeklyWordTrendDataSet.setColor(UIColor(red: 1.00, green: 0.686, blue: 0.980, alpha: 1.00))
        
        
        let monthlyData = LineChartData(dataSets: [monthlyBallDataSet,monthlyWordDataSet,monthlyBallTrendDataSet,monthlyWordTrendDataSet])
        let weeklyData = LineChartData(dataSets: [weeklyBallDataSet,weeklyWordDataSet,weeklyBallTrendDataSet,weeklyWordTrendDataSet])
        
        
        monthlyData.setDrawValues(false) // don't label points
        weeklyData.setDrawValues(false)
        
        monthlyWordTrendDataSet.circleRadius = 0.0 // no individual points for plotting for trendline
        monthlyBallTrendDataSet.circleRadius = 0.0
        weeklyWordTrendDataSet.circleRadius = 0.0
        weeklyBallTrendDataSet.circleRadius = 0.0
        
        monthlyGraph.data = monthlyData// feed data into object
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
