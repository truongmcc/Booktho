//
//  LayerExtention.swift
//  booktho
//
//  Created by christophe on 30/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

extension CALayer {
    func map( _ radius: CGFloat) {
        cornerRadius = radius
        shadowColor = UIColor.darkGray.cgColor
        shadowOpacity = 0.5
        shadowOffset = CGSize(width: 3, height: 3)
        shadowRadius = 3
    }
}
