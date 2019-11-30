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
    
    var careeList : [String] = []
    override func viewDidLoad(){
        super.viewDidLoad()
        getName()
    }
    
    func getName(){
        
        let db = Firestore.firestore()
        //direct to the games page if account is for players
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            
            let user = Auth.auth().currentUser
            if let user = user {
                //if carer signed in, get the list of all the carees
                
                let email = user.email
                //let dateNow = getDate()
                //let dateWeek = getDateWeek()
                //let dbcRef=db.collection("carers").document(email!)
                db.collection("carers").document(email!).getDocument { (document, error) in
                    if error == nil{
                        if document != nil && document!.exists{
                            self.careeList = document!.data()!["caree"] as! [String]
                            print("careelist1:")
                            print(self.careeList) // Jack - map email name to real name and display on buttons
    }
                    }
                }
            }
        }
    }
    
}
