//
//  NotificationsView.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import SwiftUI

// MARK: - Activity Notification Model
/// Notifications tab mein dikhne wali har activity (Like, Comment, ya Follow) ka model.
struct ActivityNotification: Identifiable {
    let id = UUID()
    let user: User
    let message: String
    let timeAgo: String
    let postImageName: String? // Agar post like/comment hai toh post ka chhota thumbnail dikhega, warna Follow button
}

// MARK: - Notifications View
/// Bottom Tab Bar ke 4th tab (Heart icon) par user ki recent activities (Likes, Comments, Followers) dikhane wali screen.
struct NotificationsView: View {
    
    // MARK: - Sample Notifications Data
    private let notifications: [ActivityNotification] = [
        ActivityNotification(
            user: User.MOCK_USER[1],
            message: "liked your photo.",
            timeAgo: "2m",
            postImageName: "Image"
        ),
        ActivityNotification(
            user: User.MOCK_USER[2],
            message: "started following you.",
            timeAgo: "15m",
            postImageName: nil
        ),
        ActivityNotification(
            user: User.MOCK_USER[4],
            message: "commented: \"Awesome view! 🔥\"",
            timeAgo: "1h",
            postImageName: "Image 10"
        ),
        ActivityNotification(
            user: User.MOCK_USER[5],
            message: "started following you.",
            timeAgo: "3h",
            postImageName: nil
        ),
        ActivityNotification(
            user: User.MOCK_USER[6],
            message: "liked your post.",
            timeAgo: "1d",
            postImageName: "Image 12"
        )
    ]
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(notifications) { item in
                        NotificationRowView(item: item)
                    }
                }
                .padding(.top, 12)
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Notification Row View
/// Ek single notification row (User DP + Activity Text + Follow Button ya Post Thumbnail).
struct NotificationRowView: View {
    let item: ActivityNotification
    @State private var isFollowing = false
    
    var body: some View {
        HStack(spacing: 12) {
            // 1. User Profile Link
            NavigationLink {
                ProfileView(user: item.user)
            } label: {
                CircularProfileImageView(user: item.user, size: .small)
            }
            
            // 2. Notification Message + Time
            HStack {
                Text("\(item.user.username) ")
                    .fontWeight(.semibold) +
                Text("\(item.message) ") +
                Text(item.timeAgo)
                    .foregroundStyle(Color.gray)
            }
            .font(.footnote)
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            // 3. Right Side: Post Thumbnail (agar like/comment hai) YA Follow Button (agar new follower hai)
            if let postImage = item.postImageName {
                Image(postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipped()
            } else {
                Button {
                    isFollowing.toggle()
                } label: {
                    Text(isFollowing ? "Following" : "Follow")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(width: 88, height: 30)
                        .background(isFollowing ? Color.white : Color.blue)
                        .foregroundStyle(isFollowing ? Color.black : Color.white)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isFollowing ? Color.gray : Color.clear, lineWidth: 1)
                        )
                }
            }
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    NotificationsView()
}
