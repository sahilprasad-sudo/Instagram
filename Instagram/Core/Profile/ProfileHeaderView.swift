//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user:User
    
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
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            
            
            
            Button {
                print("Hello")
            } label: {
                Text("Edit Profile")
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 360,height: 32)
            .foregroundStyle(Color.black)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1))

            Divider()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER[5])
}
