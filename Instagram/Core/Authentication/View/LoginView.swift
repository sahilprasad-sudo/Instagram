//
//  LoginView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI


struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            
            Spacer()
            
            VStack{
                //logo image
                Image("Image 7")
                    .resizable()
                    .frame(width: 200,height: 100)
                    .scaledToFit()
                
                //text fields
                VStack{
                    TextField(text: $viewModel.email) {
                        Text("Enter your email")
                            
                    }
                    .autocapitalization(.none)
                    .modifier(IGTextFieldModifier())
                    
                    SecureField(text: $viewModel.password) {
                        Text("Password")
                    }
                    .modifier(IGTextFieldModifier())
                    
                }
                
                Button {
                    print("FIrgt ")
                } label: {
                    Text("Forgot Password?")
                }
                .padding()
                .font(.caption)
                .bold()
                .foregroundStyle(Color.blue)
                .padding(.horizontal,20)
                .frame(maxWidth: .infinity,alignment: .trailing)
                
                Button {
                    Task{
                        try await viewModel.signIn()
                    }
                    
                } label: {
                    Text("Log In")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .bold()
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                .padding(.horizontal,20)
                
            }

            Spacer()
            
            Divider()
                
            
            NavigationLink {
                AddEmailView()
            } label: {
                HStack(spacing:2){
                    Text("Don't have an acoount? ") +
                    Text("Sign Up")
                        .bold()
                }
                .font(.footnote)
                
            }
            .padding()

            
        }
    }
}

#Preview {
    LoginView()
    
}
