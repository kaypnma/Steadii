//
//  careGiverSettingsViewController.swift
//  steadii
//
//  Created by 郭佳佳 on 2019-11-28.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit
import FirebaseAuth

class careGiverSettingsViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func removeButtonTapped(_ sender: Any) {
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
