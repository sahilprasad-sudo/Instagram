//
//  EditProfileView.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State var selectedImage:PhotosPickerItem?
    @Environment(\.dismiss) var dismiss
    @State private var fullname = ""
    @State private var bio = ""
    
    var body: some View {
        VStack{
            //toolbar
            VStack{
                HStack{
                    Button("Cancel"){
                        dismiss()
                    }
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        print("Update Profile info")
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                }
            }
            .padding()
            Divider()
            //edit profile pic
            VStack{
                PhotosPicker(selection: $selectedImage) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 80,height: 80)
                        .foregroundStyle(Color.white)
                        .background(.gray)
                        .clipShape(Circle())
                }
                Text("Edit Profile Picture")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
                Divider()
            }
            .padding()
            
            //edit profile info
            VStack{
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $fullname)
                Divider()
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $bio)
            }
        }
        Spacer()
    }
}

struct EditProfileRowView: View{
    let title:String
    let placeholder:String
    @Binding var text:String
    var body:some View{
        HStack{
            Text(title)
                .padding(.leading,8)
                .frame(width: 100,alignment: .leading)
            VStack{
                TextField(placeholder,text: $text)
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height:36)
    }
}

#Preview {
    EditProfileView()
}
