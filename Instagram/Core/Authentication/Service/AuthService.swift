//
//  AuthService.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import FirebaseAuth
import Combine
import FirebaseFirestore

class AuthService{
    
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser:User?
    
    init(){
        //checks if user is logged in
        
        Task{
            try await loadUserData()
        }
    }
    
    func login(email:String,password:String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        }
        catch{
            print("Error while Signing In user")
            throw error
        }
    }
    
    func createUser(email:String,password:String,username:String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid,username: username,email: email)
        }
        catch{
            print("Error while creating user")
            throw error
        }
    }
    
    @MainActor
    func loadUserData() async throws{
        self.userSession = Auth.auth().currentUser
        guard let currentUid = Auth.auth().currentUser?.uid else{
            return
        }
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        print("Snapshot data is :\(snapshot.data())")
        self.currentUser =  try? snapshot.data(as:User.self)
        
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid:String,username:String,email:String) async{
        let user = User(id:uid,username: username,email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else{
            return
        }
        do{
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("User data successfully added")
        }
        catch{
            print("Error while uploadinf user data")
        }
       
    }
    
    
}
