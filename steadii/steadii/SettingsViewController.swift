//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  ViewController.swift

//  Description/Purpose: defines view controller

//  Created by Zi Zhou Qu on 11/25/19
//  Last Updated by Zi Zhou Qu on 11/25/2019
//  Worked on by Zi Zhou Qu

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

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "signinMainSegue", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    @IBAction func buttonTapped(button: UIButton)
    {
        let defaults = UserDefaults.standard
        let currentSound = defaults.integer(forKey: "sound")
        defaults.set(-1*currentSound, forKey: "sound")
        //print ("sound set to : ", defaults.integer(forKey: "sound"))
    }
    
}
