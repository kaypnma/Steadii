//
//  ViewController.swift
//  steadii
//
//  Created by Kay Arellano on 2019-10-26.
//  Copyright © 2019 Kay Arellano. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ref = Database.database().reference()
            ref.child("carer/name").setValue("new value")
        ref.childByAutoId().setValue(["name":"Jack"])
        }
    


}

