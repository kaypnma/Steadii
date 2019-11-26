//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  CreateViewController.swift

//  Description/Purpose: Creates UI controller

//  Created by Denyse Tran on 10/28/19
//  Last Updated by Chris Keilbart on 11/03/2019
//  Worked on by Denyse Trans, Jack Guo, Dustin Seah, and Chris Keilbart

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
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth
import DLRadioButton
class CreateViewController: UIViewController {
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var createButton: LButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var playerButton: DLRadioButton!
    
    @IBOutlet weak var careGiverButton: DLRadioButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassworTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func validateFields() ->String?{
        //chceck that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||emailTextField .text?.trimmingCharacters(in:.whitespacesAndNewlines)==""||passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please fill in all the fileds"
        }
        //check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if CreateViewController.isPasswordValid(cleanedPassword)==false{
            return"Please make sure your password is valid"
        }
        return nil
    }
    static func isPasswordValid(_ password : String)->Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}" )
        return passwordTest.evaluate(with: password)
    }


    @IBAction func createButtonTapped(_ sender: Any) {
        let error  = validateFields()
        if error != nil{
            //theres something wrong with the fields, show error message
            showError(error!)
        }
        else{
            //create cleaned version of the data
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // let confirmpassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            //create a user
            Auth.auth().createUser(withEmail: email, password:password) { (result,err) in
                if  err != nil {
                    //there was an error
                    self.showError("Error creating user")
                }
                else{
                    //user was created successfully, now store the firstname, lastname, email to database
                    let data: [String: Any] = ["firstName":firstname,"lastName":lastname,"email":email,"password":password,"uid":result!.user.uid]
                   
                    let db = Firestore.firestore()
                    if self.careGiverButton.isSelected {
                        db.collection("carers").document(email).setData(data){(error)in
                            if error != nil{
                                //show error
                                self.showError("Error saving user data")
                            }
                            
                            
                            
                            
                        }
                        self.performSegue(withIdentifier: "CarerView1", sender: self)
                    }
                    if self.playerButton.isSelected{
                    db.collection("users").document(email)
                        .setData(data){(error)in
                        if error != nil{
                            //show error
                            self.showError("Error saving user data")
                        }
                        
                    }
                        self.performSegue(withIdentifier: "PlayerView1", sender: self)
                    }
                }
            }
            
        }
        //validate the fields
    }
    func showError(_ message:String){
        print("ERROR!!:"+message)
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
