//
//  UserService.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserService{
    
    static func fetchAllUsers() async throws -> [User]{
        let users = [User]()
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let document = snapshot.documents
        
        for doc in document{
            guard let user = try? doc.data(as:User.self) else{
                return users
            }
            users.append(user)
        }
        return users
    }
}
