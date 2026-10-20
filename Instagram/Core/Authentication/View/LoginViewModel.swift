//
//  LoginViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine
import FirebaseAuth

class LoginViewModel:ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
       try await AuthService.shared.login(email: email, password: password)
    }
}
