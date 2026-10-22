//
//  PostGridView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Post Grid View
/// Profile screen ke neeche 3x3 columns mein user ki posts dikhane wala reusable grid view.
struct PostGridView: View {
    
    // MARK: - Properties
    var posts: [Post]
    
    /// 3 columns ki grid configuration (har column ke beech 1 point ka gap)
    private let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    /// Screen ki चौड़ाई (width) ko 3 barabar hisson mein divide karke har square photo ka size nikalta hai
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    // MARK: - Body
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(posts) { post in
                postThumbnail(for: post)
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped() // Square frame se bahar nikalne wale image part ko trim karta hai
            }
        }
    }
    
    // MARK: - Subviews
    /// Check karta hai ki post ki photo internet URL hai ya local Asset image
    @ViewBuilder
    private func postThumbnail(for post: Post) -> some View {
        if post.imageUrl.hasPrefix("http") {
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .overlay(ProgressView())
            }
        } else {
            Image(post.imageUrl)
                .resizable()
                .scaledToFill()
        }
    }
}

#Preview {
    PostGridView(posts: Post.MOCK_Posts)
}
