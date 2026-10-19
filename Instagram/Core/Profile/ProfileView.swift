//
//  ProfileView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct ProfileView: View {
    
    let user:User
    
    
    
    
    
     var posts:[Post]{
        return Post.MOCK_Posts.filter({$0.user?.username == user.username})
    }
    
    var body: some View {

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
            
        }
        
        
    }


#Preview {
    ProfileView(user: User.MOCK_USER[2])
}
