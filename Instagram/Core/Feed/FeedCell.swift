//
//  FeedCell.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct FeedCell: View {
    let post:Post
    var body: some View {
        VStack{
            //Image + Username
            HStack{
                if let user = post.user{
                    Image(user.profileImageUrl ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height: 40)
                        .clipShape(Circle())
                    
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                
                
                Spacer()
            }
            .padding(.leading)
            //Post Image
            Image(post.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //Action Buttons
            HStack(spacing: 10){
                Button {
                    print("Like Post")
                } label: {
                    Image(systemName: "heart")
                }
                .imageScale(.large)
                Button {
                    print("Comment Post")
                } label: {
                    Image(systemName: "bubble.right")
                }
                .imageScale(.large)
                Button {
                    print("Share Post")
                } label: {
                    Image(systemName: "paperplane")
                }
                .imageScale(.large)
                Spacer()
            }
            .padding(.top,5)
            .padding(.leading)
            .tint(Color.black)
            //Likes Label
            
            Text("\(post.likes)")
                .padding(.top,1)
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading,10)
            
            //caption label
            HStack{
                Text(post.user?.username ?? "")
                    .fontWeight(.semibold) +
                Text(post.caption)
            }
            .padding(.top,1)
            .frame(maxWidth: .infinity,alignment: .leading)
            .font(.footnote)
            .padding(.leading,10)
            
            Text("6h ago")
                .padding(.top,1)
                .font(.footnote)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading,10)
                .foregroundStyle(Color.gray)
            
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_Posts[2])
}
