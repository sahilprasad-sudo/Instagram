//
//  SearchUserView.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

struct SearchUserView: View {
    @State var search:String = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(User.MOCK_USER){item in
                        HStack(spacing:10){
                            Image(item.profileImageUrl!)
                                .resizable()
                                .frame(width: 50,height: 50)
                                .clipShape(Circle())
                            Text(item.username)
                                Spacer()
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,5)
                    }
                    
                }
                .searchable(text: $search,placement: .navigationBarDrawer,prompt: "Search")
            }
        }
    }
}

#Preview {
    SearchUserView()
}
