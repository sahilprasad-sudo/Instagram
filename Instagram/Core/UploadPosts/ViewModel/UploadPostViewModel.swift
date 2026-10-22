//
//  UploadPostViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import Foundation
import PhotosUI
import SwiftUI
import Combine

// MARK: - Upload Post ViewModel
/// Gallery (`PhotosPicker`) se select ki gayi photo ko SwiftUI `Image` mein convert karne aur Firestore par nayi post upload karne ka kaam karta hai.
@MainActor
class UploadPostViewModel: ObservableObject {
    
    // MARK: - Published Properties
    /// Jab bhi user gallery se koi nayi photo pick karta hai, `didSet` automatically `loadImage` call karta hai
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    
    /// Screen par preview dikhane ke liye convert ki gayi SwiftUI `Image`
    @Published var postImage: Image?
    
    /// Server (`PostService`) par upload karne ke liye UIKit image
    private var uiImage: UIImage?
    
    // MARK: - Image Loading
    /// `PhotosPickerItem` se raw `Data` nikal kar use `UIImage` aur phir SwiftUI `Image` mein badalta hai.
    func loadImage(fromItem item: PhotosPickerItem?) async {
        // Agar item nil hai (jaise Cancel dabane par), toh safely bahar aa jao (crash nahi hoga)
        guard let item = item else { return }
        
        // Step 1: Selected item se image ka binary data nikalo
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        // Step 2: Binary data se UIKit ka UIImage banao
        guard let uiImage = UIImage(data: data) else { return }
        
        // Step 3: UIImage aur SwiftUI Image dono save kar lo
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    // MARK: - Upload Post to Firebase
    /// `PostService` ke zariye photo aur caption ko Firestore mein save karta hai.
    func uploadPost(caption: String) async throws {
        guard let uiImage = uiImage else { return }
        try await PostService.uploadPost(caption: caption, image: uiImage)
    }
}
