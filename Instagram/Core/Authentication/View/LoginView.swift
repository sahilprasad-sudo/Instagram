//
//  LoginView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Login View
/// App ki login screen jahan user email/password daal kar sign in karta hai ya naya account banane ke liye "Sign Up" par jata hai.
struct LoginView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = LoginViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // 1. Instagram Logo
                logoSection
                
                // 2. Email & Password TextFields
                inputFieldsSection
                
                // 3. Forgot Password Button
                forgotPasswordButton
                
                // 4. Log In Button
                loginButton
                
                Spacer()
                
                Divider()
                
                // 5. Bottom Sign Up Navigation Link
                signUpLinkSection
            }
        }
    }
}

// MARK: - Subviews (Code ko clean aur readable rakhne ke liye)
private extension LoginView {
    
    /// Instagram logo image
    var logoSection: some View {
        Image("Image 7")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)
    }
    
    /// Email aur Password input fields
    var inputFieldsSection: some View {
        VStack(spacing: 12) {
            TextField("Enter your email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .modifier(IGTextFieldModifier())
            
            SecureField("Password", text: $viewModel.password)
                .modifier(IGTextFieldModifier())
        }
    }
    
    /// Forgot Password button
    var forgotPasswordButton: some View {
        Button {
            print("DEBUG: Forgot Password tapped")
        } label: {
            Text("Forgot Password?")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
    }
    
    /// Primary Log In button
    var loginButton: some View {
        Button {
            Task {
                try await viewModel.signIn()
            }
        } label: {
            Text("Log In")
                .modifier(IGPrimaryButtonModifier())
        }
    }
    
    /// Bottom navigation link jo Sign-Up flow (`AddEmailView`) start karta hai
    var signUpLinkSection: some View {
        NavigationLink {
            AddEmailView()
        } label: {
            HStack(spacing: 3) {
                Text("Don't have an account?")
                Text("Sign Up")
                    .fontWeight(.bold)
            }
            .font(.footnote)
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    LoginView()
}
