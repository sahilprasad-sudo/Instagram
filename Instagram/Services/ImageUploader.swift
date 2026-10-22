//
//  ImageUploader.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import UIKit
import Foundation
#if canImport(FirebaseStorage)
import FirebaseStorage
#endif

// MARK: - Image Uploader Service
/// User ki Profile Photo ya Post Image ko server par upload karke uska image URL wapas dene wali service.
struct ImageUploader {
    
    /// `UIImage` ko compress karke Firebase Storage mein upload karta hai aur download URL return karta hai.
    static func uploadImage(image: UIImage) async throws -> String? {
        // Step 1: Image ko JPEG format mein compress karo (quality 50% taaki upload fast ho)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return nil
        }
        
        #if canImport(FirebaseStorage)
        // Step 2: Har image ke liye ek unique filename banao
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            // Step 3: Data upload karo aur uska public download URL le aao
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Firebase Storage par image upload karne mein error - \(error.localizedDescription)")
            return nil
        }
        #else
        // Fallback: Agar FirebaseStorage SDK target mein linked nahi hai, toh local placeholder image name return karo
        print("DEBUG: FirebaseStorage module linked nahi hai, fallback image use ho rahi hai.")
        return "Image"
        #endif
    }
}
