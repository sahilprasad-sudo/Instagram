//
//  SearchUserView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Mock Search User View (Practice / Preview Screen)
/// Note: Ye screen sirf `User.MOCK_USER` (dummy data) ke saath search UI test karne ke liye banayi gayi thi.
/// Actual app mein `SearchView.swift` use ho raha hai jo Firebase se real users lata hai.
struct SearchUserView: View {
    
    @State private var search = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(User.MOCK_USER) { user in
                        HStack(spacing: 12) {
                            Image(user.profileImageUrl ?? "")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(user.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .searchable(
                    text: $search,
                    placement: .navigationBarDrawer,
                    prompt: "Search"
                )
            }
            .navigationTitle("Mock Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchUserView()
}
