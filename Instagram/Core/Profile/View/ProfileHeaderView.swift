//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Profile Header View
/// Profile ke upar ka section jisme Profile Photo, Posts/Followers/Following counts, Name/Bio, aur Edit Profile / Follow button hota hai.
struct ProfileHeaderView: View {
    
    // MARK: - Properties
    let user: User
    @State private var showEditProfile = false
    @State private var isFollowed = false
    @State private var followersCount = 12
    
    /// Is user ki kitni posts hain uska dynamic count
    private var postCount: Int {
        Post.MOCK_Posts.filter { $0.user?.username == user.username || $0.ownerUid == user.id }.count
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            
            // 1. Profile Photo + Stats (Posts, Followers, Following)
            picAndStatsSection
            
            // 2. Full Name, Bio, aur Username
            bioSection
            
            // 3. Edit Profile (agar apni profile hai) ya Follow/Following button (agar kisi aur ki profile hai)
            actionButton
            
            Divider()
        }
        // "Edit Profile" dabane par full screen modal khulta hai
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

// MARK: - Subviews
private extension ProfileHeaderView {
    
    /// Left side par गोल profile photo (`CircularProfileImageView`) aur right side par 3 stats dikhata hai
    var picAndStatsSection: some View {
        HStack {
            CircularProfileImageView(user: user, size: .large)
            
            Spacer()
            
            HStack(spacing: 8) {
                UserStatView(value: postCount, title: "Posts")
                UserStatView(value: followersCount, title: "Followers")
                UserStatView(value: 24, title: "Following")
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    /// User ka naam, bio aur username left-aligned dikhata hai
    var bioSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let fullname = user.fullname {
                Text(fullname)
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            
            if let bio = user.bio {
                Text(bio)
                    .font(.footnote)
            }
            
            Text("@\(user.username)")
                .font(.footnote)
                .foregroundStyle(Color.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    /// `user.isCurrentUser` ke hisaab se "Edit Profile" ya interactive "Follow" / "Following" button dikhata hai
    var actionButton: some View {
        Button {
            if user.isCurrentUser {
                showEditProfile.toggle()
            } else {
                // Follow / Unfollow toggle karo aur follower count update karo
                isFollowed.toggle()
                followersCount += isFollowed ? 1 : -1
            }
        } label: {
            Text(buttonTitle)
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32)
                .background(buttonBackgroundColor)
                .foregroundStyle(buttonTextColor)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(buttonBorderColor, lineWidth: 1)
                )
        }
    }
    
    // MARK: - Button Styling Helpers
    var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    var buttonBackgroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .white
        } else {
            return .blue
        }
    }
    
    var buttonTextColor: Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return .white
        }
    }
    
    var buttonBorderColor: Color {
        if user.isCurrentUser || isFollowed {
            return .gray
        } else {
            return .clear
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER[5])
}
