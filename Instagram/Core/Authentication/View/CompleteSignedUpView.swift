
//
//  CompleteSignedUpView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct CompleteSignedUpView: View {
    
    @EnvironmentObject var viewModel : RegistrationViewModel
    var body: some View {
        VStack(spacing: 15){
            Spacer()
            
            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text("Click below to complete registration and start using instagram")
                .font(.footnote)
                .foregroundStyle(Color.black)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal,20)
            
            
            
            Button {
                Task{
                    try await viewModel.createUser()
                }
                
                
            } label: {
                Text("Complete Sign Up")
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
        Spacer()
        .padding(.top,40)

    }
}

#Preview {
    CompleteSignedUpView()
        .environmentObject(RegistrationViewModel())
}

