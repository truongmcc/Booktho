//
//  Alerte.swift
//  booktho
//
//  Created by christophe on 30/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit
import FirebaseAuth

// completion
typealias Success = (_ bool: Bool?) -> (Void)

class Alerte {
    static let montrer = Alerte()
    
    func erreur(message: String, controller: UIViewController) {
        let alerte = UIAlertController(title: ERREUR, message: message, preferredStyle: .alert)
        alerte.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
        controller.present(alerte, animated: true, completion: nil)
    }
    
    func alerteTF(titre: String, message: String, array: [String], controller: UIViewController, completion: Success?) {
        guard let id = Auth.auth().currentUser?.uid else {return}
        let alerte = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        // ajoute les textFields
        for a in array {
            alerte.addTextField(configurationHandler: { (textField) in
                textField.placeholder = a
            })
        }
        
        let ok = UIAlertAction(title: OK, style: .default) { (action) in
            var dict: [String: String] = [:]
            for x in (0..<array.count) {
                if let tfs = alerte.textFields, tfs.count > x {
                    let textField = tfs[x] as UITextField
                    if let string = textField.text, string != "" {
                        dict[array[x]] = string
                    }
                }
            }
            // Si toutes les valeurs ont été ajoutées au dictionnaire alors on ajoute ces données dans la base
            if dict.count == array.count {
                let reference = Refs.obtenir.baseUtilisateurs.child(id)
                reference.updateChildValues(dict)
                completion?(true)
            } else {
                completion?(false)
            }
        }
        
        alerte.addAction(ok)
        alerte.addAction(UIAlertAction(title: ANNULER, style: .cancel, handler: nil))
        controller.present(alerte, animated: true, completion: nil)
    }
    
    func deco(controller : UIViewController) {
        let alerte = UIAlertController(title: DECO, message: DECO_MESSAGE, preferredStyle: .alert)
        alerte.addAction(UIAlertAction(title: ANNULER, style: .cancel, handler: nil))
        let ok = UIAlertAction(title: OK, style: .default) { (action) in
            do {
                try Auth.auth().signOut()
                controller.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        alerte.addAction(ok)
        controller.present(alerte, animated: true, completion: nil)
    }
}
