//
//  ImageRonde.swift
//  booktho
//
//  Created by christophe on 03/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

class ImageRonde: UIImageView {
    override init(frame : CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        // forme ronde
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true // pas d'ombre
        contentMode = .scaleAspectFit
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
}
