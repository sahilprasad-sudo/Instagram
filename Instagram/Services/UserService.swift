//
//  UserService.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import Foundation
import Firebase
import FirebaseFirestore

// MARK: - User Service
/// Firestore database ke `"users"` collection se single user ya saare users fetch karne wali service.
struct UserService {
    
    /// Ek specific `uid` wale user ka profile data Firestore se fetch karta hai (e.g. post kisne daali hai ye pata karne ke liye).
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    /// Firestore ke `"users"` collection se saare registered users ki list fetch karta hai (Search/Explore screen ke liye).
    @MainActor
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        
        // Har Firestore document ko `User` struct mein convert karta hai
        return snapshot.documents.compactMap { document in
            try? document.data(as: User.self)
        }
    }
}
