//
//  radioButton.swift
//  steadii
//
//  Created by Denyse Tran on 2019-10-27.
//  Copyright © 2019 Kay Arellano. All rights reserved.
//

import UIKit

class radioButton: UIButton {
    // Images
    let checkedImage = UIImage(named: "selected_opt")! as UIImage
    let uncheckedImage = UIImage(named: "Ellipse")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
