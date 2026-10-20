//
//  RegistrationViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine

class RegistrationViewModel:ObservableObject{
    
    static let shared = RegistrationViewModel()
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws{
       try await AuthService.shared.createUser(email: email, password: password, username: username)
        username = ""
        email = ""
        password = ""
    }
}
