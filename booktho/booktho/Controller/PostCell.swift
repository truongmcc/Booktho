//
//  PostCell.swift
//  booktho
//
//  Created by christophe on 04/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func likeAppuyer(_ sender: Any) {
        
    }
}
