//
//  CurrentUserProfileView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user:User
    var posts:[Post]{
       return Post.MOCK_Posts.filter({$0.user?.username == user.username})
   }
    
    private let gridItems:[GridItem] = [
        
        .init(.flexible(),spacing:1),
        .init(.flexible(),spacing:1),
        .init(.flexible(),spacing:1),
        
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 8){
                    //Header
                    ProfileHeaderView(user: user)
                    //Post Grid View
                    
                    PostGridView(posts: posts)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(Color.black)
                    }

                }
            }
        }
        
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USER[3])
}
