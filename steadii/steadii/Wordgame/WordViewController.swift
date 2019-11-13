//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  WordViewController.swift

//  Description/Purpose: Defines states of UI

//  Created by Denyse Tran on 11/08/2019
//  Last Updated by Chris Keilbart on 11/12/2019
//  Worked on by Denyse Tran and Chris Keilbart

//  Updates from Previous Commit:
/*
    Added delay and timer
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
    Add more words and categories as desired
    Add game ending
    Add animations
*/

//  Copyright © 2019 ii Studio. All rights reserved.


import UIKit

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
        var listOfWords = ["Number", "Fraction", "Subtraction", "Addition", "Division", "Integer", "Square root", "Exponent", "Multiplication", "Decimal"]
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
        listOfWords = ["Budget", "Money", "Stocks", "Bonds", "Bank", "Teller", "Debit", "Credit", "Debt", "Asset"]
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
        listOfWords = ["Moon", "Pluto", "Comet", "Astroid", "Mercury", "Venus", "Neptune", "Saturn", "Telescope", "Hubble"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Chemistry"
        listOfWords = ["Test Tube", "Beaker", "Beaker", "Silicon", "Boron", "Periodic Table", "Acid", "Ion", "Atom", "Molecule"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Biology"
        listOfWords = ["Organism", "Cell", "Organ", "Tissue", "Anatomy", "Bone", "Species", "Genus", "Primate", "Taxonomy"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Classical Musicians"
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
        listOfWords = ["Swing", "Foxtrot", "Ballroom", "Ballet", "The Charleston", "Folk", "Square", "Line", "Tap", "The Twist"]
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
        print(drawnWord)
        print(rightInt)
        print(returnableCategories[0])
        print(returnableCategories[1])
        print(returnableCategories[2])
        print("\n")
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
    let numQuestions = 15
    let startTime = Date()
    var numWrong = 0;
    let delay = 0.65
    
    @IBOutlet var catButtons: [UIButton]!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordQuestions.reserveCapacity(numQuestions)
        for _ in 0..<numQuestions{
            wordQuestions.append(catMan.getWords())
        }
        //Game cannot be over right away, so we do not care about this result
        _ = dispNewWord()
    }
    
    //Function to display a new word and categories, to be called after a successfull guess
    //Returns true if the game should continue, otherwise the game is over
    func dispNewWord() -> Bool{
        if questionNumber < numQuestions {
            wordLabel.text = wordQuestions[questionNumber].word
            answerNumber = wordQuestions[questionNumber].answerInt
            
            for i in 0...2 {
            catButtons[i].setTitle(wordQuestions[questionNumber].categories[i], for: .normal)
            }
            
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
            //make green/play sound etc
            if !dispNewWord(){
                //Do game over stuff
                gameOver()
            }
        }
        else {
            //change the button image to wrong (red) and add an x
            numWrong += 1;
            NSLog("Wrong!")
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
            //make green/play sound etc
            if !dispNewWord(){
                //Do game over stuff
                gameOver()
            }
        }
        else {
            numWrong += 1;
            NSLog("Wrong!")
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
            //make green/play sound etc
            if !dispNewWord(){
                //Do game over stuff
                gameOver()
            }
        }
        else {
            numWrong += 1;
            NSLog("Wrong!")
        }
    }
    
    //to be called when the game is over, displays stuff and tidies up
    func gameOver(){
        let gameDuration = Double(round(1000*(-startTime.timeIntervalSinceNow))/1000)
        print(gameDuration)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
