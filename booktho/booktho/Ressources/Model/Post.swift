//
//  Post.swift
//  booktho
//
//  Created by christophe on 04/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

class Post {
    private var _id: String
    private var _date: Double
    private var _utilisateur: Utilisateur
    private var _texte: String
    private var _imageUrl: String?
    
    var id: String {
        return _id
    }
    
    var date: Double {
        return _date
    }
    
    var utilisateur: Utilisateur {
        return _utilisateur
    }
    
    var texte: String {
        return _texte
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    init(id: String, date: Double, texte: String, imageUrl: String?, utilisateur: Utilisateur) {
        self._id = id
        self._date = date
        self._texte = texte
        self._imageUrl = imageUrl
        self._utilisateur = utilisateur
    }
}

