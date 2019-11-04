//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  TextField.swift

//  Description/Purpose: Constructs the text field and alters it's appearance

//  Created by Kay Arellano on 10/27/19
//  Last Updated by Chris Keilbart on 11/03/2019
//  Worked on by Kay Arellano, Dustin Seah, and Chris Keilbart

//  Updates from Previous Commit:
/*  
    Added Header
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

import Foundation
import UIKit

class TextField : UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    private func setUpField() {
        borderStyle           = .none
        layer.cornerRadius    = frame.size.height/2
//        tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        tintColor             = UIColor.white
        textColor             = UIColor.black
        font                  = UIFont(name: "PingFangSC-Regular", size: 42)
        backgroundColor       = UIColor.white.withAlphaComponent(0.2)
        autocorrectionType    = .no
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: "PingFangSC-Regular", size: 42)!
        let placeholderColor  = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: placeholderColor,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView              = indentView
        leftViewMode          = .always
    }
}
