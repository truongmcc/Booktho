//
//  FilController.swift
//  booktho
//
//  Created by christophe on 03/04/2018.
//  Copyright © 2018 christophe. All rights reserved.
//

import UIKit

class FilController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        observerPosts()
        title = FIL
    }
    
    func observerPosts() {
        let ref = Refs.obtenir.basePost
        ref.observe(.childAdded) { (snapshot) in
            print(snapshot)
            // on va récupérer le string userId
            // de l'utilisateur à partir duquel on va récupérer le post
            if let postDict = snapshot.value as? [String: AnyObject] {
                if let userId = postDict[USER_ID] as? String {
                    Refs.obtenir.baseUtilisateurs.child(userId).observe(.value, with: { (userSnap) in
                        if let userDict = userSnap.value as? [String: String], let prenom = userDict[PRENOM], let nom = userDict[NOM] {
                            let utilisateur = Utilisateur(id: userSnap.key, prenom: prenom, nom: nom, imageUrl: userDict[IMAGE_URL])
                            if let date = postDict[DATE_POST] as? Double, let texte = postDict[TEXTE] as? String {
                                let nouveauPost = Post(id: snapshot.key, date: date, texte: texte, imageUrl: postDict[IMAGE_URL] as? String, utilisateur: utilisateur)
                                self.posts.append(nouveauPost)
                                self.posts = self.posts.sorted(by: {$0.date > $1.date})
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as? PostCell {
            cell.miseEnPlace(post: posts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as? PostCell {
            let post = posts[indexPath.row]
            var hauteur: CGFloat = 150 // hauteur de base
            if post.imageUrl != nil {
                // on veut une image carrée
                hauteur += cell.imageDuPost.frame.width
            }
            // hauteur du texte
            let taille = CGSize(width: cell.textDuPost.frame.width, height: .greatestFiniteMagnitude)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let nsString = NSString(string: post.texte)
            let hauteurDuTexte = nsString.boundingRect(with: taille, options: option, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil).height
            hauteur += hauteurDuTexte
            print(hauteur)
            return hauteur
        }
        return 0
    }
}
