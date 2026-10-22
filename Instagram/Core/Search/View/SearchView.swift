//
//  SearchView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Search / Explore View
/// Saare registered users ki list dikhata hai, search bar se filter karta hai, aur kisi user par tap karne par uski `ProfileView` kholta hai.
struct SearchView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    /// Search bar mein likhe text ke hisaab se users ko filter karta hai (Username ya Fullname match hone par)
    private var filteredUsers: [User] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                user.username.localizedCaseInsensitiveContains(searchText) ||
                (user.fullname?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredUsers) { user in
                        // User row par click karne par `navigationDestination` ke zariye uski profile khulegi
                        NavigationLink(value: user) {
                            userRowView(for: user)
                        }
                    }
                }
                .padding(.top, 8)
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer,
                    prompt: "Search users..."
                )
            }
            // Jab kisi `User` par click ho, toh uska `ProfileView` open karo
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Subviews
    /// Ek single user ki row (`CircularProfileImageView` + Username + Full Name)
    private func userRowView(for user: User) -> some View {
        HStack(spacing: 12) {
            CircularProfileImageView(user: user, size: .xSmall)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                if let fullname = user.fullname {
                    Text(fullname)
                        .foregroundStyle(Color.gray)
                }
            }
            .font(.footnote)
            
            Spacer()
        }
        .foregroundStyle(Color.black)
        .padding(.horizontal, 12)
    }
}

#Preview {
    SearchView()
}
