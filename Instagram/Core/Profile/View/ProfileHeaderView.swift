//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user:User
    @State private var showEditProfile = false
    
    var body: some View {
        VStack{
            HStack{
                Image(user.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80,height: 80)
                    .clipShape(Circle())
                Spacer()
                HStack(spacing: 8){
                    UserStatView(value: 3, title: "Posts")
                    
                    UserStatView(value: 12, title: "Followers")
                    
                    UserStatView(value: 24, title: "Following")
                    
                }
                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.bottom)
            
            VStack(alignment: .leading,spacing: 4){
                Text(user.fullname ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Text(user.bio ?? "")
                    .font(.footnote)
                Text(user.username)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            
            
            
            Button {
                if user.isCurrentUser{
                    showEditProfile.toggle()
                }
                else{
                    print("Follow User")
                }
                print("Hello")
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 360,height: 32)
            .background(user.isCurrentUser ? .white : .blue).cornerRadius(10)
            .foregroundStyle(user.isCurrentUser ? .black : .white)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1))

            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            Text("Edit Profile View")
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER[5])
}
