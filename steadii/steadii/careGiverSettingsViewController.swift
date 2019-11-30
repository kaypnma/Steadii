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


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        self.getBallGameScore()
        self.getWordGameScore()
       // print("caree out side")
       // print(careeList)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    func getDate()->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter.string(from:Date())
//        return dateString
//
//    }
//    func getDateWeek()->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter.string(from:Date().addingTimeInterval(-1*24*60*60))
//        return dateString
//    }
    func getBallGameScore(){
        let db = Firestore.firestore()
        //direct to the games page if account is for players
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
           
            let user = Auth.auth().currentUser
            if let user = user {
                //if carer signed in, get the list of all the carees
                
                let email = user.email
                //let dateNow = getDate()
                //let dateWeek = getDateWeek()
                //let dbcRef=db.collection("carers").document(email!)
                db.collection("carers").document(email!).getDocument { (document, error) in
                    if error == nil{
                        if document != nil && document!.exists{
                            self.careeList = document!.data()!["caree"] as! [String]
                            //print(careeList)
                            print("careelist1:")
                            print(self.careeList)
                        }
                    }
                    print("careelist2:")
                    print(self.careeList)
                    //read the ball game scores
                    print("ball game :")
                    for caree in self.careeList{ db.collection("users").document(caree).collection("performances").document("ballgame").getDocument(completion: { (document, error) in
                            if error == nil{
                                
                                let ballgameScore = document!.data()//![dateNow] as! Double
                                
                                print(caree)
                                //print(dateNow)
                                print(ballgameScore as Any)
                               
                            }
                            else{
                    
                            }
                            
                        })
                    }
                     print()
                    
            
                }
                
            }
            //wait(until limit: 6000) -> true
            //return "6 seconds"
    
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


}
    func getWordGameScore(){
        let db = Firestore.firestore()
        //direct to the games page if account is for players
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            
            let user = Auth.auth().currentUser
            if let user = user {
                //if carer signed in, get the list of all the carees
                
                let email = user.email
                //let dateNow = getDate()
                //let dateWeek = getDateWeek()
                //let dbcRef=db.collection("carers").document(email!)
                db.collection("carers").document(email!).getDocument { (document, error) in
                    if error == nil{
                        if document != nil && document!.exists{
                            self.careeList = document!.data()!["caree"] as! [String]
                            //print(careeList)
                            print("careelist1:")
                            print(self.careeList)
                        }
                    }
                    print("careelist2:")
                    print(self.careeList)
                    //read the ball game scores
                    print("word game :")
                    for caree in self.careeList{ db.collection("users").document(caree).collection("performances").document("wordgame").getDocument(completion: { (document, error) in
                        if error == nil{
                            
                            let ballgameScore = document!.data()//![dateNow] as! Double
                            
                            print(caree)
                            //print(dateNow)
                            print(ballgameScore as Any)
                            
                        }
                        else{
                            
                        }
                        
                    })
                    }
                    print()
                    
                    
                }
                
            }
            //wait(until limit: 6000) -> true
            //return "6 seconds"
            
            
            /*
             // MARK: - Navigation
             
             // In a storyboard-based application, you will often want to do a little preparation before navigation
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
             }
             */
            
        }
        
        
    }
}
