//
//  ProfileView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Other User Profile View
/// Jab hum Search ya Feed screen se kisi doosre user par click karte hain, toh uska profile dikhane wali screen.
struct ProfileView: View {
    
    // MARK: - Properties
    let user: User
    
    /// Sirf is user ki posts filter karke nikalta hai
    var posts: [Post] {
        Post.MOCK_Posts.filter { $0.user?.username == user.username || $0.ownerUid == user.id }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                // 1. Top Profile Header (DP, Stats, Bio, Follow/Edit Button)
                ProfileHeaderView(user: user)
                
                // 2. Bottom 3x3 Posts Grid
                PostGridView(posts: posts)
            }
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProfileView(user: User.MOCK_USER[2])
    }
}
