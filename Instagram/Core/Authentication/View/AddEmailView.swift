//
//  AddEmailView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Sign Up Step 1: Add Email View
/// Naya account banate waqt sabse pehle user se email lene wali screen.
struct AddEmailView: View {
    
    // MARK: - Properties
    /// `ContentView` se inject kiya gaya shared ViewModel jo sign-up ke teeno steps ka data store rakhta hai
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 15) {
            
            // Heading
            Text("Add your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            // Subtitle instruction
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            // Email input field
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .modifier(IGTextFieldModifier())
            
            // Step 2 (`CreateUsernameView`) par jaane ka button
            NavigationLink {
                CreateUsernameView()
            } label: {
                Text("Next")
                    .modifier(IGPrimaryButtonModifier())
            }
            
            Spacer()
        }
        .padding(.top, 40)
    }
}

#Preview {
    AddEmailView()
        .environmentObject(RegistrationViewModel())
}
