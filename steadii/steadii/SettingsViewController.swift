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
    
    @IBOutlet weak var soundOn: UIButton!
    @IBOutlet weak var soundOff: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        updateSoundButton(defaults: defaults)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            loggedOut = true
            self.performSegue(withIdentifier: "signinMainSegue", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    @IBAction func soundButtonTapped(button: UIButton)
    {
        let defaults = UserDefaults.standard
        let currentSound = defaults.integer(forKey: "sound")
        defaults.set(-1*currentSound, forKey: "sound")
        updateSoundButton(defaults: defaults)
        //print ("sound set to : ", defaults.integer(forKey: "sound"))
    }
    
    func updateSoundButton(defaults: UserDefaults) {
        if defaults.integer(forKey: "sound") == 1 {
            soundOn.isHidden = true
            soundOff.isHidden = false
        }
        else if defaults.integer(forKey: "sound") == -1 {
            soundOn.isHidden = false
            soundOff.isHidden = true
        }
        else {
            print("ERROR: invalid sound setting!")
        }
    }
    
}
