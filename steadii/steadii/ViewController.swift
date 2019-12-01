//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  ViewController.swift

//  Description/Purpose: defines view controller

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 11/03/2019
//  Worked on by Kay Arellano, Dustin Seah, Jack Guo, Denyse Tran, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Added Header
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        if defaults.integer(forKey: "sound") == 0 {
            defaults.set(1, forKey: "sound")
            print("Initialized sound setting to 1.")
        }
    }
}

