//
//  PostController.swift
//  booktho
//
//  Created by christophe on 04/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit
import FirebaseAuth

class PostController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoDuPost: UIImageView!
    @IBOutlet weak var textDuPost: UITextView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textDuPost.text = TEXTE_VIDE
        textDuPost.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rangerClavier)))
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
    }
    
    @objc func rangerClavier() {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textDuPost.text == TEXTE_VIDE {
            textDuPost.text = ""
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            photoDuPost.image = editee
        } else if let originale = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoDuPost.image = originale
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func libraryAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func envoyerPostDansBdd(_ sender: Any) {
        view.endEditing(true)
        guard let id = Auth.auth().currentUser?.uid else { return }
        if textDuPost.text == TEXTE_VIDE || textDuPost.text == "" {
            Alerte.montrer.erreur(message: TEXTE_VIDE, controller: self)
        } else {
            var dict: [String: AnyObject] = [
                TEXTE: textDuPost.text as AnyObject,
                DATE_POST: Date().timeIntervalSince1970 as AnyObject,
                USER_ID: id as AnyObject
            ]
            if let image = photoDuPost.image, let data = UIImageJPEGRepresentation(image, 0.3) {
                // récupère un id unique pour la photo
                let unique = UUID().uuidString
                // récupérer la base de photos du post
                let ref = Refs.obtenir.basePhotoDuPost.child(id).child(unique)
                // et upload de la data
                ref.putData(data, metadata: nil, completion: {(metadata, error) in
                    if let string = metadata?.downloadURL()?.absoluteString {
                        dict[IMAGE_URL] = string as AnyObject
                        self.envoyerPostSurFirebase(dict: dict)
                    }
                })
            } else {
                // envoyer dans fireBase
                envoyerPostSurFirebase(dict: dict)
            }
        }
    }
    
    func envoyerPostSurFirebase(dict: [String: AnyObject]) {
        // id unique qui permet de récupérer tous les posts
        // ici, on ne veut pas stocker les post selon les utilisateurs ; ils vont tous avoir un id unique qui va permettre de récupérer tous les posts
        let ref = Refs.obtenir.basePost.childByAutoId()
        // ajouter le dictionnaire
        ref.updateChildValues(dict)
        navigationController?.popViewController(animated: true)
        
    }
}
