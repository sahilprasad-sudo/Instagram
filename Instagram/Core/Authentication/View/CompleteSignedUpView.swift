//
//  CompleteSignedUpView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Sign Up Step 4: Complete Sign Up View
/// Sign-up ka aakhri step jahan "Complete Sign Up" dabane par Firebase mein naya user create hota hai.
struct CompleteSignedUpView: View {
    
    // MARK: - Properties
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            // Welcome message ke saath user ka chosen username
            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Click below to complete registration and start using Instagram")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            // Account create karne wala final button
            Button {
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                Text("Complete Sign Up")
                    .modifier(IGPrimaryButtonModifier())
            }
            
            Spacer()
        }
    }
}

#Preview {
    CompleteSignedUpView()
        .environmentObject(RegistrationViewModel())
}
