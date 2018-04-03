//
//  ConnectionViewController.swift
//  booktho
//
//  Created by christophe on 30/03/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit
import Firebase

class ConnectionViewController: UIViewController {

    @IBOutlet weak var pasDeCompteLabel: UILabel!
    @IBOutlet weak var connectionBouton: BoutonBooktho!
    @IBOutlet weak var mdpTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var titreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(cacherClavier)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let id = Auth.auth().currentUser?.uid {
            // Vérifier si utilisateur dans BDD
            
            // Passer à l'app
        } else {
            cacher(false)
        }
    }
    
    func cacher(_ bool: Bool) {
        titreLabel.isHidden = bool
        mailTF.isHidden = bool
        mdpTF.isHidden = bool
        connectionBouton.isHidden = bool
        pasDeCompteLabel.isHidden = bool
    }
    
    @objc func cacherClavier() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func completion(_ user: User?, _ error: Error?) {
        if let erreur = error {
            let nsErreur = erreur as NSError
            // récupérer le code erreur
            if nsErreur.code == 17011 {
                // Créer un utilisateur
                Auth.auth().createUser(withEmail: mailTF.text!, password: mdpTF.text!, completion: completion(_:_:))
            } else {
                Alerte.montrer.erreur(message: nsErreur.convertirErreurFirebaseEnString(), controller: self)
            }
        }
        if let utilisateur = user {
            // Vérifier si l'utilisateur est dans la base de données
            Alerte.montrer.erreur(message: "Utilisateur créé dans auth", controller: self)
        }
    }
    
    @IBAction func seConnecterAction(_ sender: Any) {
        self.view.endEditing(true)
        if let adresse = mailTF.text, adresse != "" {
            if let mdp = mdpTF.text, mdp != "" {
                Auth.auth().signIn(withEmail: adresse, password: mdp, completion: completion(_:_:))
            } else {
                Alerte.montrer.erreur(message: MDP_VIDE, controller: self)
            }
        } else {
            Alerte.montrer.erreur(message: ADRESSE_VIDE, controller: self)
        }
    }
}
