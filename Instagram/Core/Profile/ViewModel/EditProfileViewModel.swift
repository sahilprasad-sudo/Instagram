//
//  EditProfileViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import Combine

// MARK: - Edit Profile ViewModel
/// User ki Profile Photo, Full Name, aur Bio ko update karke Firestore mein save karne ka logic sambhalta hai.
@MainActor
class EditProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var user: User
    
    /// Jab user `PhotosPicker` se nayi DP select karta hai, `didSet` turant use `Image` mein load kar leta hai
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    
    /// Screen par preview dikhane ke liye SwiftUI `Image`
    @Published var profileImage: Image?
    
    @Published var fullname = ""
    @Published var bio = ""
    
    /// Server par upload karne ke liye UIKit image
    private var uiImage: UIImage?
    
    // MARK: - Initializer
    init(user: User) {
        self.user = user
        // Agar user ka fullname ya bio pehle se mojood hai, toh text fields mein pre-fill kar do
        self.fullname = user.fullname ?? ""
        self.bio = user.bio ?? ""
    }
    
    // MARK: - Image Picker Loader
    /// Gallery se chuni gayi photo (`PhotosPickerItem`) ko `UIImage` aur SwiftUI `Image` mein convert karta hai.
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    // MARK: - Firestore Update
    /// Check karta hai ki kya Profile Image, Name, ya Bio change hua hai, aur sirf badle hue fields ko Firestore mein update karta hai.
    func updateUserData() async throws {
        var data = [String: Any]()
        
        // 1. Agar user ne nayi profile photo select ki hai, toh use upload karke URL save karo
        if let uiImage = uiImage {
            if let imageUrl = try? await ImageUploader.uploadImage(image: uiImage) {
                data["profileImageUrl"] = imageUrl
            }
        }
        
        // 2. Agar fullname change hua hai aur khali nahi hai
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        // 3. Agar bio change hua hai aur khali nahi hai
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        // 4. Agar kuch bhi update hua hai, toh Firestore document update karo aur current user reload karo
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
            try? await AuthService.shared.loadUserData()
        }
    }
}
