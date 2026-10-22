//
//  FeedView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Home Feed View
/// App ka main Home tab jahan saare users ki posts scrollable feed mein dikhti hain.
struct FeedView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = FeedViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                // `LazyVStack` sirf wahi posts memory mein load karta hai jo screen par dikh rahi hain
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
                        FeedCell(post: post)
                    }
                }
                .padding(.top, 10)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Top-left: Instagram Logo
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Image 7")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 32)
                }
                
                // Top-right: Direct Messages (Paperplane) icon
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
            // Pull-to-refresh karne par posts dobara fetch hoti hain
            .refreshable {
                await viewModel.fetchPosts()
            }
            .onAppear {
                Task {
                    await viewModel.fetchPosts()
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
