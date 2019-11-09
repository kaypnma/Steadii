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
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet var catButtons: [LButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordQuestions = [wordQuestion(wordQuestion: "randomoword", categories: ["cat1","cat2","cat3"], answerInt: 1)]
        
        
    }
    
    func pickWord() {
        if wordQuestions.count > 0 {
            wordNumber = 0
            wordLabel.text=wordQuestions[wordNumber].wordQuestion
            //for i in 0..
            
        }
    }
    
    
    
    /*func randomWord(){
        var randomNumber = arc4random() % 4 //random number picker, between 0 and 3 - will
        randomNumber += 1 //will be between 1 and 4
        
        switch(randomNumber) {
        case 1:
            GivenWord.text = "This is a word 1"
            Category1.setTitle("randomcat1", for: UIControl.State.normal)
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
    
    @IBAction func Category1Action(_ sender: Any) {
    }
    @IBAction func Category2Action(_ sender: Any) {
    }
    @IBAction func Category3Action(_ sender: Any) {
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
