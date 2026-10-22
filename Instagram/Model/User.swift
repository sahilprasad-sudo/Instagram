//
//  User.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import Foundation
import FirebaseAuth

// MARK: - User Model
/// Har Instagram user ka data structure.
/// - `Identifiable`: SwiftUI loops (`ForEach`) mein har user ko unique `id` se pehchanne ke liye.
/// - `Codable`: Firebase Firestore ke JSON data ko Swift object mein convert karne ke liye (aur vice-versa).
/// - `Hashable`: NavigationStack (`navigationDestination`) mein user object pass karne ke liye.
struct User: Identifiable, Codable, Hashable {
    
    // MARK: - Properties
    let id: String                  // Firebase Auth se mila unique User ID (UID)
    var username: String            // User ka handle (e.g., "batman")
    var profileImageUrl: String?    // Profile photo ka naam ya URL (optional kyunki naye user ki photo nahi hoti)
    var fullname: String?           // User ka poora naam (optional)
    var bio: String?                // Profile bio text (optional)
    let email: String               // User ka login email address
    
    // MARK: - Computed Properties
    /// Check karta hai ki kya ye profile abhi logged-in user ki apni profile hai.
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return false
        }
        return currentUid == id
    }
}

// MARK: - Mock Data (Testing & Previews ke liye)
extension User {
    
    /// SwiftUI Previews aur dummy UI testing ke liye sample users ki list.
    static var MOCK_USER: [User] = [
        User(
            id: NSUUID().uuidString,
            username: "blackpanther",
            profileImageUrl: "Image",
            fullname: "Chadwick Boseman",
            bio: "Wakanda Forever",
            email: "blackpanther@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "batman",
            profileImageUrl: "Image 9",
            fullname: "Bruce Wayne",
            bio: "Gotham's Dark Knight",
            email: "batman@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "ironman",
            profileImageUrl: "Image 10",
            fullname: "Tony Stark",
            bio: "Genius, billionaire, playboy, philanthropist",
            email: "ironman@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "venom",
            profileImageUrl: "Image 15",
            fullname: "Eddie Brock",
            bio: "We are Venom",
            email: "venom@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "spiderman",
            profileImageUrl: "Image 12",
            fullname: "Peter Parker",
            bio: "Your friendly neighborhood Spider-Man",
            email: "spiderman@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "thor",
            profileImageUrl: "Image 13",
            fullname: "Thor Odinson",
            bio: "God of Thunder, Son of Odin",
            email: "thor@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "captainamerica",
            profileImageUrl: "Image 14",
            fullname: "Steve Rogers",
            bio: "I can do this all day",
            email: "cap@gmail.com"
        ),
        User(
            id: NSUUID().uuidString,
            username: "doctorstrange",
            profileImageUrl: "Image 15",
            fullname: "Stephen Strange",
            bio: "Master of the Mystic Arts",
            email: "strange@gmail.com"
        )
    ]
}
