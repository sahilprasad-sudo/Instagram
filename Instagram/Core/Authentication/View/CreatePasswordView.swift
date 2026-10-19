//
//  CreatePasswordView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct CreatePasswordView: View {
    
    @EnvironmentObject var viewModel : RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 15){
            
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your password must be atleast 6 characters in length")
                .font(.footnote)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal,20)
            
            SecureField(text: $viewModel.password) {
                Text("Password")
            }
            .modifier(IGTextFieldModifier())
            
            NavigationLink {
                CompleteSignedUpView()
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
    CreatePasswordView()
        .environmentObject(RegistrationViewModel())
}
