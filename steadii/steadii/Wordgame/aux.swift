//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  aux.swift

//  Description/Purpose: Defines states of UI

//  Created by Chris Keilbart on 11/08/2019
//  Last Updated by Chris Keilbart on 11/08/2019
//  Worked on by Chris Keilbart

//  Updates from Previous Commit:
/*
    Created file
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
    Add more words and categories as desired
*/

//  Copyright © 2019 ii Studio. All rights reserved.

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
        listOfWords = ["Parent", "Sibling", "Aunt", "Brother", "Sibling", "Uncle", "Adoption", "Mother", "Father", "Child"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Finance"
        listOfWords = ["Budget", "Money", "Stocks", "Bonds", "Bank", "Teller", "Debit", "Credit", "Debt", "Asset"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Trees"
        listOfWords = ["Spruce", "Fir", "Evergreen", "Oak", "Cedar", "Willow", "Conifer", "Walnut", "Birch", "Beech"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Sports"
        listOfWords = ["Rugby", "Football", "Tennis", "Badminton", "Hockey", "Basketball", "Baseball", "Golf", "Soccer", "Volleyball"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Famous Attractions"
        listOfWords = ["Walt Disney World", "Great Wall of China", "Taj Mahal", "Sydney Opera House", "Eiffel Tower", "Louvre Museum", "Colosseum", "Angkor Wat", "Grand Canyon", "Leaning Tower of Pisa"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Astronomy"
        listOfWords = ["Moon", "Pluto", "Comet", "Astroid", "Mercury", "Venus", "Neptune", "Saturn", "Telescope", "Hubble"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Chemistry"
        listOfWords = ["Test Tube", "Beaker", "Oxygen", "Silicon", "Carbon", "Nitrogen", "Acid", "Ion", "Atom", "Molecule"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Biology"
        listOfWords = ["Organism", "Cell", "Organ", "Tissue", "Anatomy", "Bone", "Species", "Kingdom", "Primate", "Taxonomy"]
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
        listOfWords = ["Pride and Prejudice", "Oliver Twist", "Great Expectations", "War and Peace", "Jane Erye", "Of Mice and Men", "Little Women", "The Great Gatsby", "The Scarlet Letter", "Wuthering Heights"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "70's Music"
        listOfWords = ["Dancing Queen", "Stayin' Alive", "Hotel California", "You're So Vain", "We Will Rock You", "Band On the Run", "Go Your Own Way", "Born to Run", "Stairway To Heaven", "My Sharona"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Dance"
        listOfWords = ["Swing", "Foxtrot", "Ballroom", "Ballet", "Charleston", "Folk", "Square", "Line", "Tap", "The Twist"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
        
        catName = "Art"
        listOfWords = ["Paintings", "Sculpture", "Contemporary", "Abstract", "Nouveau", "Deco", "Pottery", "Renaissance", "Drawing", "Pastel"]
        containedCategories.append(individualCategory(catName: catName, assocWords: listOfWords))
        categoryNames.append(catName)
    }
    
    //Draws the set of needed words, and creates an output containing the word, the correct category, and two incorrect categories
    func getWords() -> drawnWords{
        var rightCatNum = -1
        var rightCatName = "DrawnWordNameError"
        var drawnWord = "DrawnWordError"
        var wrongCatNum1 = -1
        var wrongCatNum2 = -1
        var wrongCatName1 = "DrawnWrongCategoryError"
        var wrongCatName2 = "DrawnWrongCategoryError"
        
        //Will not loop forever unless we draw more words than the container holds
        //Should work sufficiently fast for draws of less than 50 or so words, as it is unlikely any category is empty
        //More words and categories = less looping = more speed
        repeat{
            rightCatNum = Int.random(in: 0 ... maxCategories)
            drawnWord = containedCategories[rightCatNum].drawWord()
        }while(drawnWord != "NOWORDSLEFT")
        rightCatName = categoryNames[rightCatNum]

        //Guaranteed not to be the same as rightCatNum
        wrongCatNum1 = (Int.random(in: 1 ... maxCategories-1) + rightCatNum) % maxCategories
        wrongCatNum2 = (Int.random(in: 1 ... maxCategories-1) + rightCatNum) % maxCategories
        
        wrongCatName1 = categoryNames[wrongCatNum1]
        wrongCatName2 = categoryNames[wrongCatNum2]
        
        return drawnWords(word: drawnWord, rightCat: rightCatName, wrongCat1: wrongCatName1, wrongCat2: wrongCatName2)
    }
    
}

//Contains the results of a draw
struct drawnWords{
    let word:String
    let correctCategory:String
    let wrongCategory1:String
    let wrongCategory2:String
    
    init(word: String, rightCat: String, wrongCat1: String, wrongCat2: String){
        self.word = word
        self.correctCategory = rightCat
        self.wrongCategory1 = wrongCat1
        self.wrongCategory2 = wrongCat2
    }
}
