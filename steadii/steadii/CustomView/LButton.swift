//
//  Button.swift
//  steadii
//
//  Created by Kay Arellano on 2019-10-27.
//  Copyright © 2019 Kay Arellano. All rights reserved.
//

import Foundation
import UIKit

class LButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
//        titleLabel?.font    = UIFont(name: "Corbel Bold", size: 40)
//        titleLabel?.font = UIFont.init(name: "EuphemiaUCAS-Bold", size: 40)
        let titleColor      = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        setTitleColor(titleColor, for: .normal)
//        titleLabel?.font    = UIFont(name: "Corbel-Bold", size: 40)
        layer.cornerRadius  = frame.size.height/2
    }
}
