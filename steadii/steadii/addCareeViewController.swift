//
//  addCareeViewController.swift
//  steadii
//
//  Created by 郭佳佳 on 2019-11-29.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class addCareeViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let emailp = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
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
                db.collection("carers").document(emailc!).updateData([                    "caree": FieldValue.arrayUnion([emailp])])
            }}
        self.performSegue(withIdentifier: "careGiverMainSegue", sender: self)
        
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

