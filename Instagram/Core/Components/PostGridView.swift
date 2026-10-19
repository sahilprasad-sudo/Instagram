//
//  PostGridView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct PostGridView: View {
    
    var posts:[Post]
    
    private let gridItems:[GridItem] = [
        
        .init(.flexible(),spacing:1),
        .init(.flexible(),spacing:1),
        .init(.flexible(),spacing:1),
        
    ]
    private let imageDimension:CGFloat = UIScreen.main.bounds.width / 3 - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems,spacing: 1) {
            ForEach(posts) { index in
                Image(index.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension,height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView(posts: Post.MOCK_Posts)
}
