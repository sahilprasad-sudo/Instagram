//
//  ContentViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine
import FirebaseAuth

// MARK: - Content ViewModel
/// Ye ViewModel `AuthService` ko listen karta hai.
/// Jaise hi user login ya logout karta hai, ye `ContentView` ko turant update kar deta hai.
@MainActor
class ContentViewModel: ObservableObject {

    // MARK: - Properties
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // MARK: - Initializer
    init() {
        setupSubscribers()
    }
    
    // MARK: - Combine Subscribers
    /// `AuthService` ke `@Published` variables (`userSession` aur `currentUser`) ko observe karta hai.
    func setupSubscribers() {
        // 1. User login/logout session changes suno
        service.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
        
        // 2. Logged-in user ke profile data updates suno
        service.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
    }
}
