//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  WordViewController.swift

//  Description/Purpose: Defines states of UI

//  Created by Denyse Tran on 11/08/2019
//  Last Updated by Chris Keilbart on 11/18/2019
//  Worked on by Kay Arellano, Chris Keilbart and Denyse Tran

//  Updates from Previous Commit:
/*
    Math changes
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
    Add more words and categories as desired
    Add animations
*/

//  Copyright © 2019 ii Studio. All rights reserved.


import UIKit
import AVFoundation
import FirebaseFirestore
import FirebaseAuth

//Class for a specific category, contains the name and a list of words, randomly ordered
class individualCategory{
    var name = "NULL"
    var wordarray = ["", "", "", "", "", "", "", "", "", ""]
    let maxCategoryLength = 10
    var remaining = 10
    
    //Initializes the class with a supplied list of words in a random order
    init(catName: String, assocWords: Array<String>){
        wordarray = assocWords.shuffled()
        name = catName
    }
    
    //Returns a word from the category and also updates the amount remaining
    func drawWord() -> String{
        if (remaining == 0){
            return "NOWORDSLEFT"
        }
        else{
            //It is frankly ridiculous that swift does not support --
            remaining -= 1
            return wordarray[remaining]
        }
    }
}

//Class for the category manager, contains a list of categories, and can draw from them
class categoryManager{
    var maxCategories = -1
    var containedCategories:Array<individualCategory> = []
    var categoryNames:Array<String> = []
    
    //Will create the categories with supplied words
    init(numCats: Int){
        maxCategories = numCats
        categoryNames.reserveCapacity(numCats)
        containedCategories.reserveCapacity(numCats)
        
        var catName = "Mathematics"
        var listOfWords = ["Algebra", "Fraction", "Subtraction", "Addition", "Division", "Integer", "Square root", "Exponent", "Multiplication", "Arithmetic"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Farming"
        listOfWords = ["Agriculture", "Barn", "Plow", "Fertilizer", "Livestock", "Hay", "Bale", "Tractor", "Fields", "Crops"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "European Countries"
        listOfWords = ["Germany", "France", "Poland", "Italy", "Portugal", "Spain", "Greece", "Norway", "Finland", "Romania"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Asian Countries"
        listOfWords = ["China", "Korea", "Japan", "Thailand", "Indonesia", "Vietnam", "India", "Pakistan", "Nepal", "Cambodia"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Military"
        listOfWords = ["Rifle", "Grenade", "Bomb", "War", "Soldier", "General", "Lieutenant", "Tank", "Major", "Private"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Family"
        listOfWords = ["Parent", "Sibling", "Aunt", "Brother", "Sibling", "Uncle", "Spouse", "Mother", "Father", "Child"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Finance"
        listOfWords = ["Budget", "Money", "Stocks", "Dividend", "Bank", "Teller", "Debit", "Credit", "Debt", "Asset"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Trees"
        listOfWords = ["Spruce", "Fir", "Evergreen", "Oak", "Cedar", "Willow", "Conifer", "Sycamore", "Birch", "Beech"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Sports"
        listOfWords = ["Rugby", "Football", "Tennis", "Badminton", "Hockey", "Basketball", "Baseball", "Golf", "Soccer", "Volleyball"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Famous Attractions"
        listOfWords = ["Walt Disney World", "Great Wall of China", "Taj Mahal", "Sydney Opera House", "Eiffel Tower", "Louvre", "Colosseum", "Angkor Wat", "Grand Canyon", "Leaning Tower of Pisa"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Astronomy"
        listOfWords = ["Moon", "Pluto", "Comet", "Asteroid", "Galaxy", "Venus", "Neptune", "Saturn", "Telescope", "Hubble"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Chemistry"
        listOfWords = ["Test Tube", "Beaker", "Lab Coat", "Silicon", "Boron", "Periodic Table", "Acid", "Ion", "Atom", "Molecule"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Biology"
        listOfWords = ["Organism", "Cell", "Organ", "Tissue", "Anatomy", "Bone", "Species", "Genus", "Primate", "Taxonomy"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Famous Composers"
        listOfWords = ["Bach", "Brahms", "Beethoven", "Mozart", "Chopin", "Tchaikovsky", "Handel", "Vivaldi", "Debussy", "Wagner"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Men's First Names"
        listOfWords = ["Michael", "John", "Mark", "Timothy", "Donald", "Andrew", "Matthew", "Fred", "Joe", "Ken"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Women's First Names"
        listOfWords = ["Elizabeth", "Sarah", "Hannah", "Lucy", "Susan", "Jane", "Annie", "Joyce", "Barbara", "Mary"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Classical Literature"
        listOfWords = ["Pride and Prejudice", "Oliver Twist", "Great Expectations", "War and Peace", "The Grapes of Wrath", "Of Mice and Men", "Little Women", "The Great Gatsby", "The Scarlet Letter", "Wuthering Heights"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "70's Songs"
        listOfWords = ["Dancing Queen", "Stayin' Alive", "Hotel California", "You're So Vain", "We Will Rock You", "Band On the Run", "Go Your Own Way", "Born to Run", "Stairway To Heaven", "My Sharona"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Dance"
        listOfWords = ["Swing", "Foxtrot", "Ballroom", "Ballet", "The Charleston", "Folk", "Can-can", "Line", "Conga", "The Twist"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Art"
        listOfWords = ["Painting", "Sculpture", "Creative", "Abstract", "Nouveau", "Deco", "Pottery", "Renaissance", "Drawing", "Pastel"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
    }
    
    //Draws the set of needed words, and creates an output containing the word, the correct category, and two incorrect categories
    func getWords() -> wordQuestion{
        var rightCatNum = -1
        var drawnWord = "DrawnWordError"
        var wrongCatNum1 = -1
        var wrongCatNum2 = -1
        
        //Will not loop forever unless we draw more words than the container holds
        //Should work sufficiently fast for draws of less than 50 or so words, as it is unlikely any category is empty
        //More words and categories = less looping = more speed
        repeat{
            rightCatNum = Int.random(in: 0 ... maxCategories-1)
            drawnWord = containedCategories[rightCatNum].drawWord()
        }while(drawnWord == "NOWORDSLEFT")

        //Guaranteed not to be the same as rightCatNum
        wrongCatNum1 = (Int.random(in: 1 ... maxCategories-1) + rightCatNum) % maxCategories
        
        repeat{
        wrongCatNum2 = (Int.random(in: 1 ... maxCategories-1) + rightCatNum) % maxCategories
        }while(wrongCatNum2 == wrongCatNum1)
        
        let rightInt = Int.random(in: 0...2)
        var returnableCategories = ["","",""]
        returnableCategories[rightInt] = categoryNames[rightCatNum]
        returnableCategories[(rightInt+1)%3] = categoryNames[wrongCatNum1]
        returnableCategories[(rightInt+2)%3] = categoryNames[wrongCatNum2]
        /*print(drawnWord)
        print(rightInt)
        print(returnableCategories[0])
        print(returnableCategories[1])
        print(returnableCategories[2])
        print("\n")*/
        return wordQuestion(word: drawnWord, categories: returnableCategories, answerInt: rightInt)
    }
    
}

//Contains the results of a draw suitable for display purposes
struct wordQuestion {
    var word : String!
    var categories : [String]!
    var answerInt : Int!
}

class WordViewController: UIViewController {
    var catMan = categoryManager(numCats: 20)
    var wordQuestions = [wordQuestion]()
    var questionNumber = 0
    var answerNumber = Int()
    let numQuestions = 10
    var startTime = Date()
    var numWrong = 0
    let delay = 0.65 //originally was .65
    let buttonChangeDelay = 0.2
    
    //Variables used for countdown and game over screen
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    var seconds = 3
    var timer = Timer()
    var CountLbl: UILabel!
    
    //images for wrong and right, need to appear with better quality ones
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var wrongmark: UIImageView!
    @IBOutlet var catButtons: [UIButton]!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    //Sounds
    let defaults = UserDefaults.standard
    var audioPlayerEnd = AVAudioPlayer()
    var audioPlayerRight = AVAudioPlayer()
    var audioPlayerWrong = AVAudioPlayer()
    let soundEnd = Bundle.main.path(forResource: "end", ofType: "mp3")
    let soundRight = Bundle.main.path(forResource: "right", ofType: "mp3")
    let soundWrong = Bundle.main.path(forResource: "wrong", ofType: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding buttons initially
        self.exitButton.isHidden = true
        self.checkmark.isHidden = true
        self.wrongmark.isHidden = true
        
        //Hide all buttons for countdown screen
        hideScreen()
        
        wordQuestions.reserveCapacity(numQuestions)
        for _ in 0..<numQuestions{
            wordQuestions.append(catMan.getWords())

        }
        //Game cannot be over right away, so we do not care about this result
        do {
            audioPlayerEnd = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundEnd!))
        }
        catch {
            print(error)
        }
        
        do {
            audioPlayerRight = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundRight!))
        }
        catch {
            print(error)
        }
        
        do {
            audioPlayerWrong = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundWrong!))
        }
        catch {
            print(error)
        }
        //First start countdown and call dispNewWord
        dispCountdown()
    }
    
    //Start timer and initialize countdown label
    func dispCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        CountLbl = UILabel(frame: CGRect(x: w/2, y: h/2, width: w, height: h))
        CountLbl.center = CGPoint(x: w/2, y: h/2)
        CountLbl.countdownLabel()
        view.addSubview(CountLbl)
    }
    
    //Update timer and display text
    @objc func updateTimer() {
        if seconds > 0 {
            CountLbl.text = timerFormat(seconds)
        }
        else {
            CountLbl.text = "START"
        }
        if seconds >= 0 {
            seconds -= 1
        } else {
            CountLbl.removeFromSuperview()
            timer.invalidate()
            startTime = Date()
            _ = dispNewWord()
        }
    }
    
    func timerFormat(_ time: Int) -> String {
        let seconds = Int(time) % 60
        return String(seconds)
    }
    
    //Function to display a new word and categories, to be called after a successful guess
    //Returns true if the game should continue, otherwise the game is over
    func dispNewWord() -> Bool{
        if questionNumber < numQuestions {
            wordLabel.text = wordQuestions[questionNumber].word
            answerNumber = wordQuestions[questionNumber].answerInt
            
            for i in 0...2 {
                catButtons[i].setTitle(wordQuestions[questionNumber].categories[i], for: .normal)
                self.catButtons[i].isHidden = false
            }
            self.wordLabel.isHidden = false
            
            //Why oh why does swift not have ++...
            questionNumber += 1
            return true
        }
        else{
            //Game is over, do stuff
            return false
        }
    }
    
    //Handles what happens when the left button is tapped
    @IBAction func Cat1Button(_ sender: Any) {
        //Prevents user interaction for the specified delay
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            self.view.isUserInteractionEnabled = true
        }
        if answerNumber == 0 {
            //if answer is correct for the left button
            //display green button, add check mark
            self.catButtons[0].backgroundColor = UIColor(red:0.80, green:0.90, blue:0.42, alpha:1.0)
            self.wrongmark.isHidden = true
            self.checkmark.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+buttonChangeDelay){
                for i in 0...2 {
                    self.catButtons[i].backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
                }
                self.checkmark.isHidden = true
            }
            if !dispNewWord(){
                //Do game over stuff
                gameOver()
            }
            else {
                playAudio(sound: "right")
            }
        }
        else {
            //if the guess is wrong
            numWrong += 1;
            //NSLog("Wrong!")
            //display red button, x mark
            self.catButtons[0].backgroundColor = UIColor(red:0.98, green:0.61, blue:0.56, alpha:1.0)
            self.wrongmark.isHidden = false
            playAudio(sound: "wrong")
        }
    }
    
    //Handles what happens when the centre button is tapped
    @IBAction func Cat2Button(_ sender: Any) {
        //Prevents user interaction for the specified delay
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            self.view.isUserInteractionEnabled = true
        }
        if answerNumber == 1 {
            //if answer is correct for the left button
            //display green button, add check mark
            self.catButtons[1].backgroundColor = UIColor(red:0.80, green:0.90, blue:0.42, alpha:1.0)
            self.wrongmark.isHidden = true
            self.checkmark.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+buttonChangeDelay){
                for i in 0...2 {
                    self.catButtons[i].backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
                }
                self.checkmark.isHidden = true
            }
            if !dispNewWord(){
                //Do game over stuff
                gameOver()
            }
            else {
                playAudio(sound: "right")
            }
        }
        else {
            //if the guess is wrong
            numWrong += 1;
            //NSLog("Wrong!")
            //display red button, x mark
            self.catButtons[1].backgroundColor = UIColor(red:0.98, green:0.61, blue:0.56, alpha:1.0)
            self.wrongmark.isHidden = false
            playAudio(sound: "wrong")
        }
    }

    @IBAction func Cat3ButtonTouch(_ sender: Any) {
        if answerNumber == 2 {
            self.catButtons[2].backgroundColor = UIColor(red:0.80, green:0.90, blue:0.42, alpha:1.0)
        } else {
            self.catButtons[2].backgroundColor = UIColor(red:0.98, green:0.61, blue:0.56, alpha:1.0)
        }
    }
    //Handles what happens when the right button is pressed
    @IBAction func Cat3Button(_ sender: Any) {
        //Prevents user interaction for the specified delay
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            self.view.isUserInteractionEnabled = true
        }
        if answerNumber == 2 {
            //set button to green because correct
            self.catButtons[2].backgroundColor = UIColor(red:0.80, green:0.90, blue:0.42, alpha:1.0)
            self.wrongmark.isHidden = true
            self.checkmark.isHidden = false

            DispatchQueue.main.asyncAfter(deadline: .now()+buttonChangeDelay){
                for i in 0...2 {
                self.catButtons[i].backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
                }
                self.checkmark.isHidden = true

            }
            if !dispNewWord(){
                //Do game over stuff
                gameOver()
            }
            else {
                playAudio(sound: "right")
            }
        }
        else {
            //if the guess is wrong
            numWrong += 1;
            //display red button, x mark
            self.catButtons[2].backgroundColor = UIColor(red:0.98, green:0.61, blue:0.56, alpha:1.0)
            self.wrongmark.isHidden = false
            playAudio(sound: "wrong")
            
            //NSLog("Wrong!")
        }
    }
    
    
    //to be called when the game is over, displays stuff and tidies up
    func gameOver(){
        let gameDuration = Double(round(1000*(-startTime.timeIntervalSinceNow))/1000)
        print(gameDuration)
        self.exitButton.isHidden = false
        playAudio(sound: "end")
        updateDatabase(score:gameDuration)
        //hiding buttons and label when game ends
        hideScreen()
        
        //Game over screen initialization
        //Initialize game over label
        let gameLbl = UILabel(frame: CGRect(x: w/2, y: h/3, width: 809, height: 104))
        gameLbl.center = CGPoint(x: w/2, y: h/3)
        gameLbl.text = "GAME OVER"
        gameLbl.endLabel()
        view.addSubview(gameLbl)
        
        //Initialize score label
        let scoreLbl = UILabel(frame: CGRect(x: w/2, y: 2*h/3, width: w, height: 104))
        scoreLbl.center = CGPoint(x: w/2, y: 2*h/3)
        scoreLbl.text = "Duration: " + String(gameDuration) + " seconds"
        scoreLbl.endLabel()
        view.addSubview(scoreLbl)
    }
    
    func hideScreen() {
        for i in 0...2 {
            self.catButtons[i].isHidden = true
        }
        self.wordLabel.isHidden = true
        self.wrongmark.isHidden = true
        self.checkmark.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func playAudio(sound: String) {
        //print("sound: ", defaults.integer(forKey: "sound"))
        if defaults.integer(forKey: "sound") == 1 {
            if (sound == "end") {
                    audioPlayerEnd.play()
            }
            else if (sound == "wrong") {
                if (audioPlayerWrong.isPlaying){
                    audioPlayerWrong.stop()
                    audioPlayerWrong.currentTime = 0
                }
                audioPlayerWrong.play()
            }
            else if (sound == "right") {
                if (audioPlayerRight.isPlaying){
                    audioPlayerRight.stop()
                    audioPlayerRight.currentTime = 0
                }
                audioPlayerRight.play()
            }
        }
    }
}

//button function for border and rounded edges
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

//Will predetermine the label characteristics
extension UILabel {
    func countdownLabel() {
        textAlignment = .center
        textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        font = UIFont(name: "AvenirNext-DemiBold", size: 150)
        lineBreakMode = .byCharWrapping
    }
    func endLabel() {
        textAlignment = .center
        textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        font = UIFont(name: "AvenirNext-DemiBold", size: 80)
        lineBreakMode = .byCharWrapping
    }
}
func getDate()->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let dateString = dateFormatter.string(from:Date())
    return dateString
    
}
func updateDatabase(score: Double){
    
    let db = Firestore.firestore()
    
    if Auth.auth().currentUser != nil {
        // User is signed in.
        // ...
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let dateString = getDate()
            print("email:"+email!+"  uid:"+uid)
            db.collection("users").document(email!).collection("performances").document("wordgame").setData([dateString:score],merge:true)

            
        } else {
            // No user is signed in.
            // ...
        }
    }
    
    
    
}
