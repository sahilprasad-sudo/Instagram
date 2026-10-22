//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import Foundation
import Combine

// MARK: - Search ViewModel
/// `SearchView` ke liye Firestore se saare users ki list fetch karke hold karta hai.
@MainActor
class SearchViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var users = [User]()
    
    // MARK: - Initializer
    init() {
        Task {
            await fetchAllUsers()
        }
    }
    
    // MARK: - Data Fetching
    /// `UserService` ko call karke Firestore se saare users load karta hai (aur mock users bhi jodta hai taaki list hamesha dikhe).
    func fetchAllUsers() async {
        do {
            let fetchedUsers = try await UserService.fetchAllUsers()
            // Real Firebase users ke saath Mock users bhi rakho taaki Explore tab mein sabhi profiles dikhein
            self.users = fetchedUsers + User.MOCK_USER
        } catch {
            print("DEBUG: Users fetch karne mein error aaya - \(error.localizedDescription)")
            self.users = User.MOCK_USER
        }
    }
}
