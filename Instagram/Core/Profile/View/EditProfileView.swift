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
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
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
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
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
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.fullname)
                Divider()
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)
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
    EditProfileView(user: User.MOCK_USER[0])
}
