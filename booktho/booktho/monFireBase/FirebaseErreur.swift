//
//  FirebaseErreur.swift
//  Codabook
//
//  Created by Matthieu PASSEREL on 17/03/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

extension NSError {
    
    func convertirErreurFirebaseEnString() -> String {
        switch self.code {
        case 17000: return "token Invalide"
        case 17002: return "Le token ne convient pas"
        case 17004: return "Utilisateur invalide"
        case 17005: return "Utilisateur désactivé"
        case 17006: return "Opération non autorisée"
        case 17007 : return "E-mail déjà utilisé"
        case 17008: return "E-mail invalide"
        case 17009: return "Mot de passe Erronné"
        case 17010: return  "Trop de requêtes"
        case 17011: return "Utilisateur introuvable"
        case 17012: return "Compte existe déjà avec d'autres crédentiels"
        case 17014: return "Nécessite un Login récent"
        case 17015: return "Provider déjà utilisé"
        case 17016: return "Ce provider n'existe pas"
        case 17017: return "Token Invalide"
        case 17020: return "Erreur de réseau"
        case 17021: return "Le Token a expiré"
        case 17023: return "Clé API invalide"
        case 17024: return "Utilisateur ne correspond pas"
        case 17025: return "Utilisateur déjà en cours d'utilisation"
        case 17026: return "Mot de passe faible"
        case 17028: return "App non autorisé"
        case 17995: return "Erreur de Keychain"
        case 17999: return "Erreur interne"
        default: return "Une erreur innatendue est survenue, veuillez résessayer plus tard"
        }
    }
}
