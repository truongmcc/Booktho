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
            verifierUtilisateur(id: id)
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
            if nsErreur.code == 17011 {
                // Créer un utilisateur
                Auth.auth().createUser(withEmail: mailTF.text!, password: mdpTF.text!, completion: completion(_:_:))
            } else {
                Alerte.montrer.erreur(message: nsErreur.convertirErreurFirebaseEnString(), controller: self)
            }
        }
        if let utilisateur = user {
            verifierUtilisateur(id: utilisateur.uid)
        }
    }
    
    func verifierUtilisateur(id: String) {
        let referenceFirebase = Refs.obtenir.baseUtilisateurs.child(id)
        referenceFirebase.observe(.value) { (snapshot) in
            if snapshot.exists() {
                // le user existe : Passer à l'app
                print("utilisateur trouvé")
                // performSegue affiche la tabbarcontroller
                self.performSegue(withIdentifier: SEGUE_ID, sender: nil)
            } else {
                self.finalisation()
            }
        }
    }
    
    func finalisation() {
        Alerte.montrer.alerteTF(titre: FINALISER, message: DERNIER_PAS, array: [PRENOM, NOM], controller: self, completion: {(success) -> (Void) in
            if let bool = success, bool == true {
                // passer à l'app
                
            } else {
                self.finalisation()
            }
        })
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
