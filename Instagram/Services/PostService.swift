//
//  PostService.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

// MARK: - Post Service
/// Nayi post upload karne aur Feed / Profile ke liye Firestore se posts fetch karne wali service.
struct PostService {
    
    /// Firestore ke `"posts"` collection ka reference
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    // MARK: - Upload Post
    /// User ki chuni hui photo aur caption ko Firestore ke `"posts"` collection mein save karta hai.
    static func uploadPost(caption: String, image: UIImage) async throws {
        // Step 1: Check karo ki kaunsa user logged-in hai
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Step 2: Image upload karke URL nikalo (agar Storage configured nahi hai toh fallback `"Image"` use hoga)
        let uploadedImageUrl = try await ImageUploader.uploadImage(image: image) ?? "Image"
        
        // Step 3: Naya Firestore document reference aur `Post` object tayyar karo
        let postRef = postsCollection.document()
        let post = Post(
            id: postRef.documentID,
            ownerUid: uid,
            caption: caption,
            likes: 0,
            imageUrl: uploadedImageUrl,
            timestamp: Date(),
            user: AuthService.shared.currentUser
        )
        
        // Step 4: Locally `MOCK_Posts` ke shuruat mein bhi add kar do taaki turant Feed mein sabse upar dikhe
        await MainActor.run {
            Post.MOCK_Posts.insert(post, at: 0)
        }
        
        // Step 5: `Post` struct ko encode karke Firestore mein save karo
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        try await postRef.setData(encodedPost)
    }
    
    // MARK: - Fetch Feed Posts
    /// Home Feed ke liye Firestore se saari posts fetch karta hai aur har post ke owner (`User`) ka data attach karta hai.
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postsCollection
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        var firestorePosts = snapshot.documents.compactMap { document in
            try? document.data(as: Post.self)
        }
        
        // Har post ke `ownerUid` se us user ki details (`username`, `profileImageUrl`) fetch karke attach karo
        for i in 0 ..< firestorePosts.count {
            let ownerUid = firestorePosts[i].ownerUid
            if let postUser = try? await UserService.fetchUser(withUid: ownerUid) {
                firestorePosts[i].user = postUser
            }
        }
        
        // Agar Firestore mein abhi koi post nahi hai, toh `MOCK_Posts` dikhao taaki Feed khali na lage
        if firestorePosts.isEmpty {
            return Post.MOCK_Posts
        }
        
        return firestorePosts + Post.MOCK_Posts
    }
    
    // MARK: - Fetch User Posts
    /// Kisi ek specific user (`uid`) ki saari posts fetch karta hai (Profile Grid ke liye).
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let userPosts = snapshot.documents.compactMap { document in
            try? document.data(as: Post.self)
        }
        
        return userPosts.sorted(by: { $0.timestamp > $1.timestamp })
    }
}
