//
//  AddEmailView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct AddEmailView: View {
    
    @EnvironmentObject var viewModel : RegistrationViewModel
    
    var body: some View {
            VStack(spacing: 15){
                
                Text("Add your email")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("You'll use this email to sign in to your account ")
                    .font(.footnote)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                
                TextField(text: $viewModel.email) {
                    Text("Email")
                }
                .modifier(IGTextFieldModifier())
                .textInputAutocapitalization(.never)
                
                NavigationLink {
                    CreateUsernameView()
                } label: {
                    Text("Next")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                .bold()
                .padding(.horizontal,20)

                
            }
            .padding(.top,40)
            Spacer()
    }
}

#Preview {
    AddEmailView()
        .environmentObject(RegistrationViewModel())
}
