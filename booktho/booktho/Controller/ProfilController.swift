//
//  ProfilController.swift
//  booktho
//
//  Created by christophe on 03/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfilController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoDeProfil: ImageRonde!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    
    var profil: Utilisateur?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenirProfil()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        photoDeProfil.isUserInteractionEnabled = true
        photoDeProfil.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(prendrePhoto)) )
    }
    
    // MARK: Actions
    @IBAction func modifierProfilAction(_ sender: Any) {
        if let bouton = sender as? UIButton {
            var array = [String]()
            switch bouton.tag {
            case 0: array.append(PRENOM)
            case 1: array.append(NOM)
            default: break
            }
            guard array.count == 1 else { return }
            Alerte.montrer.alerteTF(titre: MODIFIER, message: array[0], array: array, controller: self, completion: nil)
        }
    }
    
    @IBAction func decoAction(_ sender: Any) {
        Alerte.montrer.deco(controller: self)
    }
    
    // MARK: Mise à jour profil
    func obtenirProfil() {
        // récupère l'id de l'authentifié
        guard let id = Auth.auth().currentUser?.uid else { return }
        // va checker dans la base si l'utilisateur est dans la base à partir de son id
        let ref = Refs.obtenir.baseUtilisateurs.child(id)
        ref.observe(.value) { (snapshot) in
            print(snapshot)
            if let dict = snapshot.value as? [String:String], let prenom = dict[PRENOM], let nom = dict[NOM] {
                let nouvelUtilisateur = Utilisateur(prenom: prenom, nom: nom, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            }
        }
    }
    
    func miseAJourDonnees() {
        guard profil != nil else { return }
        prenomLabel.text = "Prénom : " + self.profil!.prenom
        nomLabel.text = "Nom : " + self.profil!.nom
        photoDeProfil.telecharger(self.profil!.imageUrl)
    }
    
    // MARK: Photos
    @objc func prendrePhoto() {
        Alerte.montrer.photo(imagePicker: imagePicker, controller: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage?
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = editee
        } else if let originale = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = originale
        }
        guard image != nil, let data = UIImageJPEGRepresentation(image!, 0.2) else { return }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
