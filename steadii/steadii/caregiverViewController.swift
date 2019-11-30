//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  caregiverViewController.swift

//  Description/Purpose: defines view controller

//  Created by Dustin Seah on 11/28/19
//  Last Updated by Dustin Seah on 11/28/2019
//  Worked on by Dustin Seah and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  First commit
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
import FirebaseAuth
import FirebaseFirestore

var GlobalAccountInfo = accountInfo (name:"kmn", email:"pls@gmail.com", monthlyBallScore: [1.0], weeklyBallScore : [1.0], monthlyWordScore : [1.0], weeklyWordScore : [1.0], monthlyBallX : [1.0], weeklyBallX : [1.0], monthlyWordX : [1.0], weeklyWordX : [1.0], monthlyBallYTrend : [1.0], weeklyBallYTrend : [1.0], monthlyWordYTrend : [1.0], weeklyWordYTrend : [1.0] )

class accountInfo{
    var name : String
    var email : String
    var monthlyBallScore : [Double]
    var weeklyBallScore : [Double]
    var monthlyWordScore : [Double]
    var weeklyWordScore : [Double]
    
    var monthlyBallX : [Double]
    var weeklyBallX : [Double]
    var monthlyWordX : [Double]
    var weeklyWordX : [Double]
    
    let monthlyXTrend = [0.0,29.0]
    let weeklyXTrend = [0.0,6.0]
    
    var monthlyBallYTrend : [Double]
    var weeklyBallYTrend : [Double]
    var monthlyWordYTrend : [Double]
    var weeklyWordYTrend : [Double]

   
    init(name:String, email:String, monthlyBallScore:[Double], weeklyBallScore:[Double], monthlyWordScore : [Double], weeklyWordScore : [Double], monthlyBallX : [Double], weeklyBallX : [Double], monthlyWordX : [Double], weeklyWordX : [Double], monthlyBallYTrend : [Double], weeklyBallYTrend : [Double], monthlyWordYTrend : [Double], weeklyWordYTrend : [Double]){
        self.name = name
        self.email = email
        self.monthlyBallScore = monthlyBallScore
        self.weeklyBallScore = weeklyBallScore
        self.monthlyWordScore = monthlyWordScore
        self.weeklyWordScore = weeklyWordScore
        self.monthlyBallX = monthlyBallX
        self.weeklyBallX = weeklyBallX
        self.monthlyWordX = monthlyWordX
        self.weeklyWordX = weeklyWordX
        self.monthlyBallYTrend = monthlyBallYTrend
        self.weeklyBallYTrend = weeklyBallYTrend
        self.monthlyWordYTrend = monthlyWordYTrend
        self.weeklyWordYTrend = weeklyWordYTrend
    }
}

class caregiverViewController : UIViewController{
    @IBOutlet weak var Player1: LButton!
    @IBOutlet weak var Player2: LButton!
    @IBOutlet weak var Player3: LButton!
    @IBOutlet weak var Player4: LButton!
    @IBOutlet weak var Player5: LButton!
    @IBOutlet weak var Player6: LButton!
    
    let maxPlayers = 6
    
    //You can use this as the list of players
    var careeList : [String] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        dispNamesOnButtons()
        //updateData(email: "cc@gmail.com", name: "test")
    }
    
    //Jack: don't worry about these
    @IBAction func but1Clicked(_ sender: Any) {
        //Pass the username and the email of my button to the updatedata function
        print(1)
    }
    
    @IBAction func but2Clicked(_ sender: Any) {
        print(2)
    }
    
    @IBAction func but3Clicked(_ sender: Any) {
        print(3)
    }
    
    @IBAction func but4Clicked(_ sender: Any) {
        print(4)
    }
    
    @IBAction func but5Clicked(_ sender: Any) {
        print(5)
    }
    
    @IBAction func but6Clicked(_ sender: Any) {
        print(6)
    }
    
    //Function to display names on buttons, Jack you should do this once you read the list of names, then hide them as needed
    func dispNamesOnButtons(){
        Player1.setTitle("Test1", for: .normal)
    }
    
    //Resets the global class to prep it for reuse, don't worry about it
    func resetGlobal(){
        GlobalAccountInfo.name = "Reset"
        GlobalAccountInfo.email = "Reset"
        GlobalAccountInfo.monthlyBallScore = []
        GlobalAccountInfo.weeklyBallScore = []
        GlobalAccountInfo.monthlyWordScore = []
        GlobalAccountInfo.weeklyWordScore = []
        GlobalAccountInfo.monthlyBallX = []
        GlobalAccountInfo.weeklyBallX = []
        GlobalAccountInfo.monthlyWordX = []
        GlobalAccountInfo.weeklyWordX = []
        GlobalAccountInfo.monthlyBallYTrend = []
        GlobalAccountInfo.weeklyBallYTrend = []
        GlobalAccountInfo.monthlyWordYTrend = []
        GlobalAccountInfo.weeklyWordYTrend = []
    }
    
    //Fills the global class with data
    func updateData(email: String, name: String){
        //var ballscores
        resetGlobal()
        //This function will parse the data and send it to the global class
        //JACK: Please return me some array of data from the last 30 days right here, I will parse it.
    }
}
