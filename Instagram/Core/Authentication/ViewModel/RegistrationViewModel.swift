//
//  RegistrationViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine

// MARK: - Registration ViewModel
/// Sign-Up ke 4 screens (`AddEmailView` -> `CreateUsernameView` -> `CreatePasswordView` -> `CompleteSignedUpView`)
/// ke beech user ki details (`email`, `username`, `password`) store karne aur naya account create karne ke liye use hota hai.
class RegistrationViewModel: ObservableObject {
    
    // MARK: - Properties
    static let shared = RegistrationViewModel()
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    // MARK: - Actions
    /// `AuthService` ko call karke Firebase mein naya user banata hai aur form fields ko reset kar deta hai.
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            email: email,
            password: password,
            username: username
        )
        
        // Account banne ke baad fields khali (reset) kar do
        username = ""
        email = ""
        password = ""
    }
}
