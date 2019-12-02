//
//  careGiverSettingsViewController.swift
//  steadii
//
//  Created by Jack Guo on 2019-11-28.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class careGiverSettingsViewController: UIViewController {
     var careeList: [String] = []
    //let catDownloader = CatDownloader()


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func removeButtonTapped(_ sender: Any) {

        let emailp = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if emailp == ""{
            let alert = UIAlertController(title: "Warning", message: "please fill in the email address before remove", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            
            
            self.present(alert, animated: true)
        }
        //remove the player from careelist in database
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                //let uid = user.uid
                let db = Firestore.firestore()
                let emailc = user.email
                //print(emailp)
                db.collection("carers").document(emailc!).updateData([                    "caree": FieldValue.arrayRemove([emailp])])
            }}
        self.performSegue(withIdentifier: "caregiverMainSegue", sender: self)
       
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
