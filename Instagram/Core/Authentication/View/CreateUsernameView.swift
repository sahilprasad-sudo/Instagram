//
//  CreateUsernameView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Sign Up Step 2: Create Username View
/// Email daalne ke baad user se uska unique username lene wali screen.
struct CreateUsernameView: View {
    
    // MARK: - Properties
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 15) {
            
            // Heading
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            // Subtitle instruction
            Text("Pick a username for your new account. You can always change it later.")
                .font(.footnote)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            // Username input field
            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .modifier(IGTextFieldModifier())
            
            // Step 3 (`CreatePasswordView`) par jaane ka button
            NavigationLink {
                CreatePasswordView()
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
    CreateUsernameView()
        .environmentObject(RegistrationViewModel())
}
