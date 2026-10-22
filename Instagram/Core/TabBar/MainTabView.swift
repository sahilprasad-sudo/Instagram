//
//  MainTabView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Main Tab View
/// Login hone ke baad dikhne wali bottom navigation bar (5 tabs: Feed, Search, Upload, Notifications, Profile).
struct MainTabView: View {
    
    // MARK: - Properties
    let user: User
    
    /// Abhi kaunsa tab selected hai (0 = Feed, 1 = Search, 2 = Upload, 3 = Notifications, 4 = Profile)
    @State private var selectedIndex = 0
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedIndex) {
            
            // Tab 0: Home Feed
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            // Tab 1: Search / Explore Users
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            
            // Tab 2: Upload New Post
            UploadPostView(tabIndex: $selectedIndex)
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .tag(2)
            
            // Tab 3: Activity Notifications
            NotificationsView()
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(3)
            
            // Tab 4: Current User Profile
            CurrentUserProfileView(user: user)
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(4)
        }
        .tint(Color.black) // Selected tab icon ka color black rakhta hai
    }
}

#Preview {
    MainTabView(user: User.MOCK_USER[0])
}
