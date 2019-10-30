//
//  CreateViewController.swift
//  steadii
//
//  Created by Denyse Tran on 2019-10-28.
//  Copyright © 2019 Kay Arellano. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            let ref = Database.database().reference()
                ref.child("carer/name").setValue("new value")
           // ref.childByAutoId().setValue(["name":"Jack"])
//                ref.child("player").observeSingleEvent(of: .value){(snapshot)in let playerdata = snapshot.value as? [String : Any]}
        let ref2 = Database.database().reference()
        let updates = ["carer/name":"back to Dustin","player/name":"new john"]
        ref2.updateChildValues(updates)
        ref.child("score/date").removeValue()
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
