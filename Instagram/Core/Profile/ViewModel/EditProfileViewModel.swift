//
//  EditProfileViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import Foundation
import FirebaseFirestore
import Combine

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var fullname = ""
    @Published var bio = ""
    
    init(user: User) {
        self.user = user
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func updateUserData() async throws {
        var data = [String: Any]()
        
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
            try? await AuthService.shared.loadUserData()
        }
    }
}
