//
//  SearchView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach(User.MOCK_USER){user in
                        NavigationLink(value: user) {
                            HStack{
                                Image(user.profileImageUrl ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40,height: 40)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text(user.username)
                                        .bold()
                                    
                                    if let fullname = user.fullname{
                                        Text(fullname)
                                    }
                                    
                                }
                                Spacer()
                                .font(.footnote)
                            }
                            .tint(Color.black)
                            .padding(.horizontal,10)
                            .padding(.vertical,2)
                        }
                    
                    }
                    
                }
                .padding(.top,8)
                .searchable(text: $searchText,placement:.navigationBarDrawer,prompt: "Search")
                
            }
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    SearchView()
}
