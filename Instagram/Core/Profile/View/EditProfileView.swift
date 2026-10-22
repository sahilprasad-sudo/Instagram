//
//  EditProfileView.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import SwiftUI
import PhotosUI

// MARK: - Edit Profile View
/// Logged-in user ko apni Profile Photo, Name, aur Bio update karne ki screen deta hai.
struct EditProfileView: View {
    
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    // MARK: - Initializer
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            // 1. Top Bar (Cancel | Edit Profile | Done)
            toolbarSection
            
            Divider()
            
            // 2. Profile Picture Picker (Gallery se photo chunne ke liye)
            profilePictureSection
            
            // 3. Name aur Bio Input Rows
            profileInfoSection
            
            Spacer()
        }
    }
}

// MARK: - Subviews
private extension EditProfileView {
    
    /// Top navigation bar jisme Cancel aur Done buttons hain
    var toolbarSection: some View {
        HStack {
            Button("Cancel") {
                dismiss()
            }
            
            Spacer()
            
            Text("Edit Profile")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                Task {
                    try await viewModel.updateUserData()
                    dismiss()
                }
            } label: {
                Text("Done")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
    
    /// Gallery se nayi profile picture choose karne wala button.
    /// Agar user ne nayi photo pick ki hai toh wo dikhegi, warna purani `CircularProfileImageView` dikhegi.
    var profilePictureSection: some View {
        PhotosPicker(selection: $viewModel.selectedImage) {
            VStack(spacing: 8) {
                if let image = viewModel.profileImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else {
                    CircularProfileImageView(user: viewModel.user, size: .large)
                }
                
                Text("Edit profile picture")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
                
                Divider()
            }
        }
        .padding(.vertical, 8)
    }
    
    /// Name aur Bio edit karne wale text rows
    var profileInfoSection: some View {
        VStack {
            EditProfileRowView(
                title: "Name",
                placeholder: "Enter your name",
                text: $viewModel.fullname
            )
            
            EditProfileRowView(
                title: "Bio",
                placeholder: "Enter your bio",
                text: $viewModel.bio
            )
        }
    }
}

// MARK: - Reusable Edit Profile Row Component
/// Edit Profile screen mein har ek field (jaise "Name" ya "Bio") ke liye reusable row.
struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USER[0])
}
