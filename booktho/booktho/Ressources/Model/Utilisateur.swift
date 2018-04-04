//
//  Utilisateur.swift
//  
//
//  Created by christophe on 03/04/2018.
//

import UIKit

class Utilisateur {
    private var _prenom: String
    private var _nom: String
    private var _imageUrl: String?
    private var _id: String
    
    var id: String {
        return _id
    }
    
    var prenom: String {
        return _prenom
    }
    
    var nom: String {
        return _nom
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    init (id: String, prenom: String, nom: String, imageUrl: String?) {
        self._id = id
        self._prenom = prenom
        self._nom = nom
        self._imageUrl = imageUrl
    }
}
