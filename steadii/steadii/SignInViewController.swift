//
//  SignInViewController.swift
//  steadii
//
//  Created by 郭佳佳 on 2019-11-18.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class SignInViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: LButton!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in

            }
            else {
                // go to firestore to check for the account type
                let db = Firestore.firestore()
           //direct to the games page if account is for players
                db.collection("users").document(email).getDocument(completion: { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                            print("found the account as a player")
                            self.performSegue(withIdentifier: "PlayerView", sender: self)
                        }
                    }
                    
                    
                })
                //direct to the carers' view for carers accounts
                db.collection("carers").document(email).getDocument(completion: { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                            print("found the account as a carer")
                            self.performSegue(withIdentifier: "CarerView", sender: self)
                        }
                    }
                    
                    
                })

                
            
            }
        }
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
