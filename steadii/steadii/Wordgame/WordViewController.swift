//
//  WordViewController.swift
//  steadii
//
//  Created by Denyse Tran on 2019-11-08.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit

struct wordQuestion {
    var wordQuestion : String!
    var categories : [String]!
    var answerInt : Int!
}


class WordViewController: UIViewController {
    var wordQuestions = [wordQuestion]()
    var wordNumber = Int()
    var answerNumber = Int()
    
    @IBOutlet var catButtons: [UIButton]!
    
    
    @IBOutlet weak var wordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordQuestions = [wordQuestion(wordQuestion: "randomowdsfsdord", categories: ["cat1","cat2","cat3"], answerInt: 0),
                         wordQuestion(wordQuestion: "randomowfsdfsord", categories: ["cat1","cat2","cat3"], answerInt: 1),
                         wordQuestion(wordQuestion: "randomodsaword", categories: ["cat1","cat2","cat3"], answerInt: 2),] //needs editing
        
    }
    
    func pickWord() {
        if wordQuestions.count > 0 {
            wordNumber = 0
            wordLabel.text=wordQuestions[wordNumber].wordQuestion
            
            answerNumber = wordQuestions[wordNumber].answerInt
            
            for i in 0..<catButtons.count{
            catButtons[i].setTitle(wordQuestions[wordNumber].categories[i], for: .normal) //needs editing
            }
            wordQuestions.remove(at: wordNumber)
            
        }
        else {
            //probably change the button image to correct (green) and add a checkmark
            NSLog("Done!")
        }
    }
    
    
    @IBAction func Cat1Button(_ sender: Any) {
        if answerNumber == 0 {
            pickWord()
        }
        else {
            //change the button image to wrong (red) and add an x
            NSLog("Wrong!")
        }
        
    }
    @IBAction func Cat2Button(_ sender: Any) {
        if answerNumber == 1 {
            pickWord()
        }
        else {
            NSLog("Wrong!")
        }
    }

    @IBAction func Cat3Button(_ sender: Any) {
        if answerNumber == 2 {
            pickWord()
        }
        else {
            NSLog("Wrong!")
        }
    }
    
    
    /*func randomWord(){
        var randomNumber = arc4random() % 4 //random number picker, between 0 and 3 - will
        randomNumber += 1 //will be between 1 and 4
        
        switch(randomNumber) {
        case 1:
            GivenWord.text = "This is a word 1"
            break
        case 2:
            GivenWord.text = "This is a word 1"
            break
        case 3:
            GivenWord.text = "This is a word 1"
            break
        case 4:
            GivenWord.text = "This is a word 1"
            break
        default:
            break
            
        }*/
        
    //}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
