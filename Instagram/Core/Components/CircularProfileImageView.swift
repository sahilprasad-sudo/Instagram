//
//  CircularProfileImageView.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import SwiftUI

// MARK: - Profile Image Size Enum
/// Alag-alag screens (Feed, Search, Profile Header, Edit Profile) ke liye standard profile photo sizes.
enum ProfileImageSize {
    case xSmall // 40x40 (Feed cell aur Search row ke liye)
    case small  // 48x48 (Notifications aur Comments ke liye)
    case medium // 64x64
    case large  // 80x80 (Profile Header aur Edit Profile ke liye)
    
    var dimension: CGFloat {
        switch self {
        case .xSmall: return 40
        case .small:  return 48
        case .medium: return 64
        case .large:  return 80
        }
    }
}

// MARK: - Circular Profile Image View
/// Poori app mein user ki गोल (circular) profile photo dikhane wala reusable component.
/// Ye 3 cases automatically handle karta hai:
/// 1. Agar `profileImageUrl` web URL (`http`/`https`) hai -> `AsyncImage` se download karke dikhata hai.
/// 2. Agar `profileImageUrl` Assets.xcassets ka naam hai (e.g. `"Image 9"`) -> local `Image` dikhata hai.
/// 3. Agar `profileImageUrl` nil ya khali hai -> default gray person icon dikhata hai.
struct CircularProfileImageView: View {
    
    // MARK: - Properties
    let user: User?
    let size: ProfileImageSize
    
    // MARK: - Body
    var body: some View {
        if let imageUrl = user?.profileImageUrl, !imageUrl.isEmpty {
            if imageUrl.hasPrefix("http") {
                // Case 1: Firebase Storage ya internet URL wali image
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
            } else {
                // Case 2: Assets folder mein rakhi local mock image
                Image(imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(Circle())
            }
        } else {
            // Case 3: Jab user ne abhi tak koi profile photo upload nahi ki hai
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER[0], size: .large)
}
