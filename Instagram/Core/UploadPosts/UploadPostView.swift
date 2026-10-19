//
//  UploadPostView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerIsPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex:Int
    var body: some View {
        VStack{
            //action toolbar
            HStack{
                Button {
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                } label: {
                    Text("Cancel")
                }
                Spacer()
                Text("New Post")
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    print("Upload")
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }

            }
            .padding(.horizontal)
            //post image & caption
            HStack(spacing:8){
                if let image = viewModel.postImage{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100,height: 100)
                        .clipped()
                }
                
                TextField("Enter Your Caption",text:$caption,axis: .vertical)
            }
            
            Spacer()
        }
        .onAppear{
            imagePickerIsPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerIsPresented, selection: $viewModel.selectedImage)
        .padding()
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
