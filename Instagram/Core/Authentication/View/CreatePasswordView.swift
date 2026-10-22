//
//  CreatePasswordView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Sign Up Step 3: Create Password View
/// Username select karne ke baad password set karne wali screen.
struct CreatePasswordView: View {
    
    // MARK: - Properties
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 15) {
            
            // Heading
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            // Subtitle instruction
            Text("Your password must be at least 6 characters in length")
                .font(.footnote)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            // Password input field (characters hide rehte hain)
            SecureField("Password", text: $viewModel.password)
                .modifier(IGTextFieldModifier())
            
            // Final Step (`CompleteSignedUpView`) par jaane ka button
            NavigationLink {
                CompleteSignedUpView()
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
    CreatePasswordView()
        .environmentObject(RegistrationViewModel())
}
