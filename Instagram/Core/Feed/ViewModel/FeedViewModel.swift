//
//  FeedViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 22/10/26.
//

import Foundation
import Combine

// MARK: - Feed ViewModel
/// Home Feed ke liye `PostService` se saari posts load aur refresh karne wala ViewModel.
@MainActor
class FeedViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var posts = [Post]()
    
    // MARK: - Initializer
    init() {
        Task {
            await fetchPosts()
        }
    }
    
    // MARK: - Fetch Posts
    /// Firestore aur Mock data se feed posts fetch karta hai.
    func fetchPosts() async {
        do {
            self.posts = try await PostService.fetchFeedPosts()
        } catch {
            // Agar internet ya Firestore rules ki wajah se error aaye, toh Mock Posts dikhao
            print("DEBUG: Feed posts fetch karne mein error - \(error.localizedDescription)")
            self.posts = Post.MOCK_Posts
        }
    }
}
