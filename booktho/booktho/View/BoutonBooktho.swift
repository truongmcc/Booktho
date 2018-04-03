//
//  BoutonBooktho.swift
//  booktho
//
//  Created by christophe on 30/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

class BoutonBooktho: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        backgroundColor = UIColor.white
        tintColor = GREEN_BOOKTHO
        layer.map(10)
    }
    
}
