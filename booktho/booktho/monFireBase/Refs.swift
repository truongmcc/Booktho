//
//  Refs.swift
//  GoogleToolboxForMac
//
//  Created by christophe on 03/04/2018.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class Refs {
    static let obtenir = Refs()
    
    // récèpère la référence base de la base de données :
    // --> accès à la racinde de la base de données
    let baseBDD = Database.database().reference()
    
    // crée un sous dossier dans la base de donnée qui sera utilisateur (une sous base de données)
    var baseUtilisateurs: DatabaseReference {
        return baseBDD.child(UTILISATEUR)
    }
}
