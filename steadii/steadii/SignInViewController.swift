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
import DLRadioButton

var loggedOut = true

class SignInViewController: UIViewController {
    
    struct defaultsKeys {
        static let keyOne = "firstStringKey"
        static let keyTwo = "secondStringKey"
        static let keyL = loggedOut
    }
    @IBOutlet weak var passwordTextField: UITextField!
    var remember = false
    
    @IBOutlet weak var loginButton: LButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func rememberButtonTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if remember{
            print("yes")
            self.rememberButton.isSelected = false
            remember = false
            defaults.set("firstStringKey", forKey: defaultsKeys.keyOne)
            defaults.set("secondStringKey", forKey: defaultsKeys.keyTwo)
            print("set to false")
            
            return
        }
        else if !remember{
            print("not")
            self.rememberButton.isSelected = true
            remember = true
            print("set to true")
            return
        }
        else{
            return
        }
    }
    
    @IBOutlet weak var rememberButton: DLRadioButton!
    override func viewDidLoad() {
      
        super.viewDidLoad()
        rememberButton.isSelected = true
        remember = true
        let defaults = UserDefaults.standard
        
        // Do any additional setup after loading the view.
       
        if defaults.integer(forKey: "sound") == 0 {
            defaults.set(1, forKey: "sound")
            print("Initialized sound setting to 1.")
        }
        if defaults.string(forKey: defaultsKeys.keyOne) != "firstStringKey" && defaults.string(forKey: defaultsKeys.keyTwo) != "secondStringKey"{
            emailTextField.text = defaults.string(forKey: defaultsKeys.keyOne)
            passwordTextField.text = defaults.string(forKey: defaultsKeys.keyTwo)
            {
               // print("autoLogin")
                autoLogIn(email: defaults.string(forKey: defaultsKeys.keyOne) ?? "", password: defaults.string(forKey: defaultsKeys.keyTwo) ?? "")}
            
           // prin
            
        }
        else{
            
        }
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        //loggedOut = false
       // defaults.set(loggedOut, forKey: defaultsKeys.keyL)
        // Signing in the user
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                
                    let alert = UIAlertController(title: "Warning", message: "Incorrect account or password!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
            else {
                // go to firestore to check for the account type
                let db = Firestore.firestore()
           //direct to the games page if account is for players
                db.collection("users").document(email).getDocument(completion: { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                           // print("found the account as a player")
                            if self.rememberButton.isSelected{
                            defaults.set(email, forKey: defaultsKeys.keyOne)
                            defaults.set(password, forKey: defaultsKeys.keyTwo)
                            }
                            self.remember = true
                            self.performSegue(withIdentifier: "PlayerView", sender: self)
                        }
                    }
                })
                //direct to the carers' view for carers accounts
                db.collection("carers").document(email).getDocument(completion: { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                           // print("found the account as a carer")
                            if self.rememberButton.isSelected{
                                print("remember selected")
                                defaults.set(email, forKey: defaultsKeys.keyOne)
                                defaults.set(password, forKey: defaultsKeys.keyTwo)
                                self.remember = true
                                
                            }
                            self.performSegue(withIdentifier: "CarerView", sender: self)
                        }
                    }
                })
            }
        }
    }
    func autoLogIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                
                let alert = UIAlertController(title: "Warning", message: "Incorrect account or password!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else {
                // go to firestore to check for the account type
                let db = Firestore.firestore()
                //direct to the games page if account is for players
                db.collection("users").document(email).getDocument(completion: { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                            // print("found the account as a player")
//                            if self.rememberButton.isSelected{
//                                defaults.set(email, forKey: defaultsKeys.keyOne)
//                                defaults.set(password, forKey: defaultsKeys.keyTwo)
//                            }
                            self.performSegue(withIdentifier: "PlayerView", sender: self)
                        }
                    }
                })
                //direct to the carers' view for carers accounts
                db.collection("carers").document(email).getDocument(completion: { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                            // print("found the account as a carer")
//                            if self.rememberButton.isSelected{
//                                print("remember selected")
//                                defaults.set(email, forKey: defaultsKeys.keyOne)
//                                defaults.set(password, forKey: defaultsKeys.keyTwo)
//
//                            }
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
