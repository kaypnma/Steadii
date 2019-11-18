//
//  SignInViewController.swift
//  steadii
//
//  Created by 郭佳佳 on 2019-11-18.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit
import FirebaseAuth

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
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
            }
            else {
                
//                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//                
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
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
