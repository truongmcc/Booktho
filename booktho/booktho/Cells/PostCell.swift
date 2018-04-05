//
//  PostCell.swift
//  booktho
//
//  Created by christophe on 04/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PostCell: UITableViewCell {

    @IBOutlet weak var photoDeProfil: ImageRonde!
    @IBOutlet weak var nomEtPrenom: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textDuPost: UILabel!
    @IBOutlet weak var boutonLikes: UIButton!
    @IBOutlet weak var nombreDeLikes: UILabel!
    @IBOutlet weak var imageDuPost: UIImageView!
    
    var post: Post!
    
    func miseEnPlace(post: Post) {
        self.post = post
        photoDeProfil.telecharger(self.post.utilisateur.imageUrl)
        nomEtPrenom.text = self.post.utilisateur.prenom + " " + self.post.utilisateur.nom
        imageDuPost.telecharger(self.post.imageUrl)
        textDuPost.text = self.post.texte
        if self.post.imageUrl == nil {
            imageDuPost.isHidden = true
        } else {
            imageDuPost.isHidden = false
        }
        let date = Date(timeIntervalSince1970: self.post.date)
        let formatter = DateFormatter()
        let calendrier = Calendar.current
        if calendrier.isDateInToday(date) {
            formatter.dateStyle = .none
            formatter.timeStyle = .short
        } else {
            formatter.dateStyle = .short
            formatter.timeStyle = .none
        }
        let dateString = formatter.string(from: date)
        dateLabel.text = dateString
        
        // likes
        if let id = Auth.auth().currentUser?.uid {
            if self.post.likes.contains(id) {
                boutonLikes.setImage(#imageLiteral(resourceName: "like_plein"), for: .normal)
            } else {
                boutonLikes.setImage(#imageLiteral(resourceName: "like_vide"), for: .normal)
            }
        } else {
            boutonLikes.setImage(#imageLiteral(resourceName: "like_vide"), for: .normal)
        }
        observerLikes()
        
        // label likes
        if self.post.likes.count == 0 {
            nombreDeLikes.text = ""
        } else {
            nombreDeLikes.text = String(self.post.likes.count) + " " + LIKES
        }
    }
    
    func observerLikes() {
        let ref = Refs.obtenir.basePost.child(self.post.id)
        ref.observe(.childAdded) { (snap) in
            // Ajouté
            if let array = snap.value as? NSArray, let arrayString = array as? [String], arrayString != self.post.likes {
                self.post.maj(likes: arrayString)
                self.miseEnPlace(post: self.post)
            }
        }
        ref.observe(.childRemoved) { (snap) in
            // Enlevé
            if let array = snap.value as? NSArray, let arrayString = array as? [String] {
                var mesLikes = self.post.likes
                for string in arrayString {
                    if let index = mesLikes.index(of: string){
                        mesLikes.remove(at: index)
                    }
                }
                self.post.maj(likes: mesLikes)
                self.miseEnPlace(post: self.post)
            }
        }
        ref.observe(.childChanged) { (snap) in
            // Changé
            if let array = snap.value as? NSArray, let arrayString = array as? [String] {
                self.post.maj(likes: arrayString)
                self.miseEnPlace(post: self.post)
            }
        }
    }
    
    @IBAction func likeAppuyer(_ sender: Any) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        var array = self.post.likes
        if !array.contains(id) {
            array.append(id)
        } else {
            if let index = array.index(of: id) {
                array.remove(at: index)
            }
        }
        Refs.obtenir.basePost.child(self.post.id).updateChildValues([LIKES: array])
    }
}
