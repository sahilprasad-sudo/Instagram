//
//  UploadPostView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI
import PhotosUI

// MARK: - Upload Post View
/// Gallery se photo select karke caption ke saath nayi post upload karne wali screen.
struct UploadPostView: View {
    
    // MARK: - Properties
    @State private var caption = ""
    @State private var imagePickerIsPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    
    /// `MainTabView` ka selected tab index (Cancel ya Upload ke baad wapas Home feed `0` par jaane ke liye)
    @Binding var tabIndex: Int
    
    // MARK: - Body
    var body: some View {
        VStack {
            // 1. Top Toolbar (Cancel | New Post | Upload)
            actionToolbar
            
            // 2. Selected Photo Preview + Caption Input
            postInputSection
            
            Spacer()
        }
        .padding()
        // Screen khulte hi automatically photo gallery picker open karo
        .onAppear {
            imagePickerIsPresented.toggle()
        }
        // iOS Photo Gallery Picker
        .photosPicker(
            isPresented: $imagePickerIsPresented,
            selection: $viewModel.selectedImage
        )
    }
}

// MARK: - Subviews & Helper Functions
private extension UploadPostView {
    
    /// Top bar jisme Cancel aur Upload buttons hain
    var actionToolbar: some View {
        HStack {
            Button("Cancel") {
                clearPostDataAndReturnToFeed()
            }
            
            Spacer()
            
            Text("New Post")
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                Task {
                    try await viewModel.uploadPost(caption: caption)
                    clearPostDataAndReturnToFeed()
                }
            } label: {
                Text("Upload")
                    .fontWeight(.semibold)
            }
        }
    }
    
    /// Chhoti photo preview aur uske bagal mein caption likhne ka TextField
    var postInputSection: some View {
        HStack(spacing: 8) {
            if let image = viewModel.postImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
            }
            
            TextField("Enter your caption...", text: $caption, axis: .vertical)
        }
    }
    
    /// Caption aur selected photo clear karke user ko wapas Home Feed (tab 0) par bhejta hai
    func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
