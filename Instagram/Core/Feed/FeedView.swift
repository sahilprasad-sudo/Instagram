//
//  FeedView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing:35){
                    ForEach(Post.MOCK_Posts) { post in
                        FeedCell(post: post)
                    }
                }
                .padding(.top,10)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Image 7")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 62)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
        
    }
}

#Preview {
    FeedView()
}
