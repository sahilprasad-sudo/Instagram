//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 21/10/26.
//

import Foundation
import Combine

class SearchViewModel:ObservableObject{
    @Published var users = [User]()
    
    init(){
        Task{
            try await fetchAllUsers()
        }
    }
    
    func fetchAllUsers()async{
        do{
            self.users = try await UserService.fetchAllUsers()
        }
        catch{
            print("Error while fetching all users")
        }
    }
}
