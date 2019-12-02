//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  caregiverViewController.swift

//  Description/Purpose: defines view controller

//  Created by Dustin Seah on 11/28/19
//  Last Updated by Chris Keilbart on 11/28/2019
//  Worked on by Dustin Seah and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  I wrote this through gitlab online so it probably will not compile first time. 
    I added the name printing and hiding
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
import Foundation

//The global graph information class, we must construct it with garbage data
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
    //Counted the way one would read a book
    @IBOutlet weak var Player1: LButton!
    @IBOutlet weak var Player2: LButton!
    @IBOutlet weak var Player3: LButton!
    @IBOutlet weak var Player4: LButton!
    @IBOutlet weak var Player5: LButton!
    @IBOutlet weak var Player6: LButton!
    
    //You can use this as the list of players
    var playerList : [String] = []
    var emailList : [String] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //Must be called before display for obvious reasons
        getPlayersAndEmails()
    }
    
    //Jack: don't worry about these
    @IBAction func but1Clicked(_ sender: Any) {
        //Pass the username and the email of my button to the updatedata function
        //The username and email for each button should be known inside of the class
        print(1)
        resetGlobal()
        updateData(email: self.emailList[0], playerName: self.playerList[0])
    }
    
    @IBAction func but2Clicked(_ sender: Any) {
        print(2)
        resetGlobal()
        updateData(email: self.emailList[1], playerName: self.playerList[1])
    }
    
    @IBAction func but3Clicked(_ sender: Any) {
        print(3)
        resetGlobal()
        updateData(email: self.emailList[2], playerName: self.playerList[2])
    }
    
    @IBAction func but4Clicked(_ sender: Any) {
        print(4)
        resetGlobal()
        updateData(email: self.emailList[3], playerName: self.playerList[3])
    }
    
    @IBAction func but5Clicked(_ sender: Any) {
        print(5)
        resetGlobal()
        updateData(email: self.emailList[4], playerName: self.playerList[4])
    }
    
    @IBAction func but6Clicked(_ sender: Any) {
        print(6)
        resetGlobal()
        updateData(email: self.emailList[5], playerName: self.playerList[5])
    }
    
    //Function to display names on buttons
    func dispNamesOnButtons(){
        print(self.playerList)
        self.playerList.reverse()
        switch playerList.count {
            case 0:
                Player1.isHidden = true
                Player2.isHidden = true
                Player3.isHidden = true
                Player4.isHidden = true
                Player5.isHidden = true
                Player6.isHidden = true
            case 1:
                Player1.setTitle(playerList[0], for: .normal)
                Player2.isHidden = true
                Player3.isHidden = true
                Player4.isHidden = true
                Player5.isHidden = true
                Player6.isHidden = true
            case 2:
                Player1.setTitle(playerList[0], for: .normal)
                Player2.setTitle(playerList[1], for: .normal)
                Player3.isHidden = true
                Player4.isHidden = true
                Player5.isHidden = true
                Player6.isHidden = true
            case 3:
                Player1.setTitle(playerList[0], for: .normal)
                Player2.setTitle(playerList[1], for: .normal)
                Player3.setTitle(playerList[2], for: .normal)
                Player4.isHidden = true
                Player5.isHidden = true
                Player6.isHidden = true
            case 4: 
                Player1.setTitle(playerList[0], for: .normal)
                Player2.setTitle(playerList[1], for: .normal)
                Player3.setTitle(playerList[2], for: .normal)
                Player4.setTitle(playerList[3], for: .normal)
                Player5.isHidden = true
                Player6.isHidden = true
            case 5:
                Player1.setTitle(playerList[0], for: .normal)
                Player2.setTitle(playerList[1], for: .normal)
                Player3.setTitle(playerList[2], for: .normal)
                Player4.setTitle(playerList[3], for: .normal)
                Player5.setTitle(playerList[4], for: .normal)
                Player6.isHidden = true
            case 6:
                Player1.setTitle(playerList[0], for: .normal)
                Player2.setTitle(playerList[1], for: .normal)
                Player3.setTitle(playerList[2], for: .normal)
                Player4.setTitle(playerList[3], for: .normal)
                Player5.setTitle(playerList[4], for: .normal)
                Player6.setTitle(playerList[5], for: .normal)
            default:
                //Bad stuff happened, better display nothing just in case
                Player1.isHidden = true
                Player2.isHidden = true
                Player3.isHidden = true
                Player4.isHidden = true
                Player5.isHidden = true
                Player6.isHidden = true
        }
    }
    
    //Func get list of names and emails for all of the managed players
    func getPlayersAndEmails(){

        let db = Firestore.firestore()
        //direct to the games page if account is for players
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            
            let user = Auth.auth().currentUser
            if let user = user {
                //if carer signed in, get the list of all the carees
                
                let email = user.email
                db.collection("carers").document(email!).getDocument { (document, error) in
                    if error == nil{
                        if document != nil && document!.exists{
                            self.emailList = document!.data()!["caree"] as! [String]
                            for caree in self.emailList{
                                print(caree)
                                db.collection("users").document(caree).getDocument(completion: { (document, error) in
                                if error == nil{
                                    let data = document!.data()
                                    let firstName = String(data!["firstName"] as? String ?? "")
                                    let lastName =  String(data!["lastName"] as? String ?? "")
                                    let fullName = firstName+" "+lastName
                                    
                                    self.playerList.append(fullName)
                                }
                                else{
                                    
                                }
                                    if (caree == self.emailList[0]){
                                        print(self.playerList)
                                        self.dispNamesOnButtons()
                                    }
                            })
                                
                            }
                            
                        }
                    }}

            }}
        
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
    
    //Function to generate the linear regression data given an input array
    //Returns the value of the line at lowEnd and Highend
    func linReg(x: [Double], y: [Double], lowEnd: Double, highEnd: Double) -> [Double]{
        //y=mx+b
        //m=sum((x-xmean)(y-ymean)/sum((x-xmean)^2)
        if x.count == 1 {
            return [y[0], y[0]]
        }
        var numerator = 0.0
        var denominator = 0.0
        let xmean = mean(input: x)
        let ymean = mean(input: y)
        for i in 0..<x.count{
            numerator += (x[i]-xmean)*(y[i]-ymean)
            denominator += (x[i]-xmean)*(x[i]-xmean)
        }
        let m = numerator/denominator
        let b = ymean - m*xmean
        
        return [lowEnd*m+b, highEnd*m+b]
    }
    //Todo: Handle 0 data points case
    //Does what it says on the tin
    func mean(input: [Double]) -> Double {
        var avg = 0.0
        for i in input{
            avg += i
        }
        return avg/Double(input.count) //@chris I was getting an error with this it was simply "avg/input.count" before. I just casted it, not sure if that makes a difference
    }
    
    //Fills the global class with data

    func getDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from:Date())
        return dateString
    }
    func getDateMinus1(dateOld : String,i : Double)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd" //Your date format
        let dateNew = dateFormatter.date(from: dateOld)
        var temp = dateNew
        temp!.addTimeInterval(-1*24*60*60*i)
        let dateString = dateFormatter.string(for: temp)
        return dateString!
    }
    func updateData(email: String, playerName: String){
        //var ballscores
        resetGlobal()
        //This function will parse the data and send it to the global class
        //JACK: Please return me some array of data from the last 30 days right here, I will parse it.
        //print("in update")
        let db = Firestore.firestore()
        var ballScores:[Double] = []
        var wordScores:[Double] = []
        var ballDates:[String] = []
        var wordDates:[String] = []
    db.collection("users").document(email).collection("performances").document("ballgame").getDocument(completion: { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let date = self.getDate()
                for i in 0..<30{
                    let d = Double(i)
                    let  dateNew = self.getDateMinus1(dateOld:date,i:d)
                    let performance1 = data![dateNew] as? Double ?? 0.0
                    //if performance1 != 0{
                        ballScores.append(performance1)
                        ballDates.append(dateNew)
                    //}
                }
                print(ballDates)
                print(ballScores)
                var weekScores = [ballScores[0], ballScores[1], ballScores[2], ballScores[3], ballScores[4], ballScores[5], ballScores[6]]
                ballScores.reverse()
                //ballDates.reverse()
                weekScores.reverse()
                
                var monthDatesIndex = [0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0]
                var weekDatesIndex = [0.0,1.0,2.0,3.0,4.0,5.0,6.0]
                for i in (0..<30).reversed(){
                    if ballScores[i] == 0.0 {
                        ballScores.remove(at: i)
                        monthDatesIndex.remove(at: i)
                    }
                }
                for i in (0..<7).reversed(){
                    if weekScores[i] == 0.0 {
                        weekScores.remove(at: i)
                        weekDatesIndex.remove(at: i)
                    }
                }
                GlobalAccountInfo.monthlyBallScore = ballScores
                GlobalAccountInfo.monthlyBallX = monthDatesIndex
                GlobalAccountInfo.weeklyBallScore = weekScores
                GlobalAccountInfo.weeklyBallX = weekDatesIndex
                GlobalAccountInfo.name = playerName
                GlobalAccountInfo.email = email
                GlobalAccountInfo.weeklyBallYTrend = self.linReg(x: weekDatesIndex, y: weekScores, lowEnd: 0.0, highEnd: 6.0)
                GlobalAccountInfo.monthlyBallYTrend = self.linReg(x: monthDatesIndex, y: ballScores, lowEnd: 0.0, highEnd: 29.0)
            } else {
                print("Document does not exist")
            }
        })
    db.collection("users").document(email).collection("performances").document("wordgame").getDocument(completion: { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let date = self.getDate()
                for i in 0..<30{
                    let d = Double(i)
                    let  dateNew = self.getDateMinus1(dateOld:date,i:d)
                    let performance1 = data![dateNew] as? Double ?? 0.0
                     //if performance1 != 0{
                        wordScores.append(performance1)
                        wordDates.append(dateNew)  
                    //}
                }
                print(wordScores)
                print(wordDates)
                
                var weekScores = [wordScores[0], wordScores[1], wordScores[2], wordScores[3], wordScores[4], wordScores[5], wordScores[6]]
                wordScores.reverse()
                //ballDates.reverse()
                weekScores.reverse()
                
                var monthDatesIndex = [0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0]
                var weekDatesIndex = [0.0,1.0,2.0,3.0,4.0,5.0,6.0]
                for i in (0..<30).reversed(){
                    if wordScores[i] == 0.0 {
                        wordScores.remove(at: i)
                        monthDatesIndex.remove(at: i)
                    }
                }
                for i in (0..<7).reversed(){
                    if weekScores[i] == 0.0 {
                        weekScores.remove(at: i)
                        weekDatesIndex.remove(at: i)
                    }
                }
                GlobalAccountInfo.monthlyWordScore = wordScores
                GlobalAccountInfo.monthlyWordX = monthDatesIndex
                GlobalAccountInfo.weeklyWordScore = weekScores
                GlobalAccountInfo.weeklyWordX = weekDatesIndex
                GlobalAccountInfo.weeklyWordYTrend = self.linReg(x: weekDatesIndex, y: weekScores, lowEnd: 0.0, highEnd: 6.0)
                GlobalAccountInfo.monthlyWordYTrend = self.linReg(x: monthDatesIndex, y: wordScores, lowEnd: 0.0, highEnd: 29.0)
            } else {
                print("Document does not exist")
            }
        })
    }

}

