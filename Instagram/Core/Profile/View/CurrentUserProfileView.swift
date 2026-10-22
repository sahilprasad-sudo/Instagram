//
//  CurrentUserProfileView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Current User Profile View
/// Bottom Tab Bar ke 5th tab par logged-in user ki apni profile dikhane wali screen (top-right mein Sign Out button ke saath).
struct CurrentUserProfileView: View {
    
    // MARK: - Properties
    let user: User
    
    /// Logged-in user ki posts filter karke nikalta hai
    var posts: [Post] {
        Post.MOCK_Posts.filter { $0.user?.username == user.username || $0.ownerUid == user.id }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    // 1. Top Profile Header (DP, Stats, Bio, Edit Profile Button)
                    ProfileHeaderView(user: user)
                    
                    // 2. Bottom 3x3 Posts Grid
                    PostGridView(posts: posts)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Top-right menu button: Tap karne par user Sign Out ho jata hai
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USER[3])
}
