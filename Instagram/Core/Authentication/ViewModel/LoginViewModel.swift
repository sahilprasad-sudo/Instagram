//
//  LoginViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine
import FirebaseAuth

// MARK: - Login ViewModel
/// `LoginView` ke text fields (`email` aur `password`) ka data hold karta hai aur `AuthService` ke zariye user ko sign in karwata hai.
class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var email = ""
    @Published var password = ""
    
    // MARK: - Actions
    /// `AuthService.shared.login` ko call karke existing user ko login karta hai.
    func signIn() async throws {
        try await AuthService.shared.login(email: email, password: password)
    }
}
