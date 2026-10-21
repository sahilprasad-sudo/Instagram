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
    @MainActor
    static func fetchAllUsers() async throws -> [User]{
        
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({try? $0.data(as: User.self)})
    }
}
