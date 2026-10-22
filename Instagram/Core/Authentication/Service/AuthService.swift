//
//  AuthService.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

// MARK: - Authentication Service
/// Ye class Firebase Authentication (Login, Sign Up, Sign Out) aur current user ka data load/save karne ka kaam karti hai.
/// `AuthService.shared` (Singleton pattern) use kiya gaya hai taaki poori app mein ek hi auth state rahe.
class AuthService {
    
    // MARK: - Properties
    /// Singleton instance jo poori app mein share hota hai
    static let shared = AuthService()
    
    /// Firebase ka login session (agar nil hai matlab user logged out hai)
    @Published var userSession: FirebaseAuth.User?
    
    /// Firestore database se fetch kiya gaya current logged-in user ka complete profile data
    @Published var currentUser: User?
    
    // MARK: - Initializer
    init() {
        // App khulte hi check karo ki user pehle se logged-in hai ya nahi
        Task {
            try? await loadUserData()
        }
    }
    
    // MARK: - Auth Functions
    
    /// Existing user ko email aur password se Sign In karta hai.
    @MainActor
    func login(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: Login karne mein error aaya - \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Naye user ka account Firebase Auth mein banata hai aur uska profile Firestore mein save karta hai.
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            // Step 1: Firebase Auth mein email/password register karo
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // Step 2: Firestore database mein user ka profile document save karo
            await uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG: Account create karne mein error aaya - \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Current logged-in user ka data Firestore ke `"users"` collection se fetch karta hai.
    @MainActor
    func loadUserData() async throws {
        // Check karo ki Firebase Auth mein koi user logged-in hai ya nahi
        self.userSession = Auth.auth().currentUser
        
        guard let currentUid = userSession?.uid else {
            return
        }
        
        // Firestore se us UID wala document mangwao aur `User` model mein convert karo
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    /// User ko Sign Out karta hai aur local session clear kar deta hai.
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    // MARK: - Helper Functions
    
    /// Sign up ke waqt user ki basic details Firestore ke `"users"` collection mein upload karta hai.
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        
        // Swift `User` struct ko Firestore dictionary format mein encode karo
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {
            return
        }
        
        do {
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("DEBUG: User data Firestore mein save ho gaya")
        } catch {
            print("DEBUG: User data upload karne mein error - \(error.localizedDescription)")
        }
    }
}
