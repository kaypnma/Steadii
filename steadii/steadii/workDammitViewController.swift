//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  ViewController.swift

//  Description/Purpose: defines view controller

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 11/21/2019
//  Worked on by Kay Arellano, Dustin Seah, Jack Guo, Denyse Tran, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Used fake data to plot fake graphs onto caretaker view
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
class workDammit: UIViewController {
    @IBOutlet weak var spag: LineChartView!
    @IBOutlet weak var spagger: LineChartView!
    func fakedisplay(){
        let entry1 = ChartDataEntry(x: 1.0, y: 2.0)
        let entry2 = ChartDataEntry(x: 2.0, y: 4.0)
        let entry3 = ChartDataEntry(x: 3.0, y: 8.0)
        let dataSet1 = LineChartDataSet(entries: [entry1, entry2, entry3], label: "Label")
        let data = LineChartData(dataSets: [dataSet1])
        spag.data = data
        spagger.data = data
        spagger.chartDescription?.text = "Desc2"
        spag.chartDescription?.text = "Desc"
        
        spag.notifyDataSetChanged()
        spagger.notifyDataSetChanged()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fakedisplay()
    }
}

