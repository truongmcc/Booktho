//
//  VueBooktho.swift
//  booktho
//
//  Created by christophe on 04/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

class VueBooktho: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        backgroundColor = .white
        layer.map(10)
    }

}
