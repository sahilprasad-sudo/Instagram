//
//  ContentView.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import SwiftUI

// MARK: - Root Content View
/// Ye view decide karta hai ki user ko `LoginView` dikhana hai ya `MainTabView` (Home Screen).
struct ContentView: View {
    
    // MARK: - ViewModels
    /// Auth state (`userSession` aur `currentUser`) track karne ke liye
    @StateObject var viewModel = ContentViewModel()
    
    /// Sign-up steps (`AddEmailView` -> `CreateUsernameView` -> `CreatePasswordView`) mein data share karne ke liye
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    // MARK: - Body
    var body: some View {
        Group {
            // Agar user logged in NAHI hai, toh Login screen dikhao
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            }
            // Agar user logged in hai aur uska profile data aa chuka hai, toh Main Tab Bar dikhao
            else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
