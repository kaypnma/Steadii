//
//  TextField.swift
//  steadii
//
//  Created by Kay Arellano on 2019-10-27.
//  Copyright © 2019 Kay Arellano. All rights reserved.
//

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
