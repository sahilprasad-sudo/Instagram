//
//  CreateUsernameView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct CreateUsernameView: View {
    
    @EnvironmentObject var viewModel : RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 15){
            
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Pick a username for your new account.You can always change it later ")
                .font(.footnote)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal,20)
            
            TextField(text: $viewModel.username) {
                Text("Username")
            }
            .modifier(IGTextFieldModifier())
            .textInputAutocapitalization(.never)
            
            NavigationLink {
                CreatePasswordView()
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
    CreateUsernameView()
        .environmentObject(RegistrationViewModel())
}
