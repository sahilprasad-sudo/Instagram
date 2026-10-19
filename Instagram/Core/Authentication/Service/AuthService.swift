//
//  AuthService.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import FirebaseAuth
import Combine

class AuthService{
    
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        //checks if user is logged in
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email:String,password:String) async throws{
        
    }
    
    func createUser(email:String,password:String,username:String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        }
        catch{
            print("Error while creating user")
            throw error
        }
    }
    
    func loadUserData() async throws{
        
    }
    
    func signOut(){
        
    }
    
}
