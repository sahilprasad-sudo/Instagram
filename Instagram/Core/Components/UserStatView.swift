//
//  UserStatView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - User Stat View
/// Profile screen par "Posts", "Followers", aur "Following" ka number aur label dikhane wala reusable component.
struct UserStatView: View {
    
    // MARK: - Properties
    let value: Int      // Stat ka count (e.g., 12)
    let title: String   // Stat ka naam (e.g., "Followers")
    
    // MARK: - Body
    var body: some View {
        VStack {
            // Count number (uper)
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            // Label text (neeche)
            Text(title)
                .font(.footnote)
        }
        .frame(width: 76)
    }
}

#Preview {
    UserStatView(value: 12, title: "Posts")
}
