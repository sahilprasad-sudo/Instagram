//
//  Post.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import Foundation

// MARK: - Post Model
/// Instagram feed aur profile grid mein dikhne wali har post ka data structure.
struct Post: Identifiable, Hashable, Codable {
    
    // MARK: - Properties
    let id: String          // Har post ki unique ID
    let ownerUid: String    // Jis user ne post daali hai uski ID
    let caption: String     // Post ke neeche likha caption
    var likes: Int          // Post par kitne likes hain
    let imageUrl: String    // Post ki photo ka naam ya URL
    let timestamp: Date     // Post kab upload hui thi
    var user: User?         // Post kis user ki hai (username aur DP dikhane ke liye)
}

// MARK: - Mock Posts (Testing & Previews ke liye)
extension Post {
    
    /// Feed aur Profile Grid ke Previews test karne ke liye dummy posts.
    static var MOCK_Posts: [Post] = [
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[0].id,
            caption: "Wakanda Forever! Protecting the kingdom.",
            likes: 1240,
            imageUrl: "Image",
            timestamp: Date(),
            user: User.MOCK_USER[0]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[1].id,
            caption: "Gotham never sleeps, and neither do I.",
            likes: 856,
            imageUrl: "Image 9",
            timestamp: Date().addingTimeInterval(-3600), // 1 hour ago
            user: User.MOCK_USER[1]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[2].id,
            caption: "Testing out the new Mark LXXXV armor in the lab.",
            likes: 3420,
            imageUrl: "Image 10",
            timestamp: Date().addingTimeInterval(-7200), // 2 hours ago
            user: User.MOCK_USER[2]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[3].id,
            caption: "Eyes, lungs, pancreas... so many snacks, so little time.",
            likes: 412,
            imageUrl: "Image 15",
            timestamp: Date().addingTimeInterval(-14400), // 4 hours ago
            user: User.MOCK_USER[3]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[4].id,
            caption: "Just swinging through Queens! Caught a great view from the top of the Chrysler Building.",
            likes: 1890,
            imageUrl: "Image 12",
            timestamp: Date().addingTimeInterval(-28800), // 8 hours ago
            user: User.MOCK_USER[4]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[5].id,
            caption: "Another glorious day in New Asgard. Bring me another coffee!",
            likes: 2150,
            imageUrl: "Image 13",
            timestamp: Date().addingTimeInterval(-43200), // 12 hours ago
            user: User.MOCK_USER[5]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[6].id,
            caption: "Morning run around D.C. On your left!",
            likes: 1530,
            imageUrl: "Image 14",
            timestamp: Date().addingTimeInterval(-86400), // 1 day ago
            user: User.MOCK_USER[6]
        ),
        Post(
            id: NSUUID().uuidString,
            ownerUid: User.MOCK_USER[7].id,
            caption: "Studying the Book of Vishanti at the Sanctum Sanctorum.",
            likes: 945,
            imageUrl: "Image 15",
            timestamp: Date().addingTimeInterval(-172800), // 2 days ago
            user: User.MOCK_USER[7]
        )
    ]
}
