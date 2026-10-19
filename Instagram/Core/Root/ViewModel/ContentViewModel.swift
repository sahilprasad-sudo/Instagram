//
//  ContentViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine
import FirebaseAuth

class ContentViewModel:ObservableObject{

    private let service = AuthService.shared
    
    @Published var userSession:FirebaseAuth.User?
    
    private var cancellables =  Set<AnyCancellable>()
    
    init(){
        setupSubscribers()
    }
    
    func setupSubscribers(){
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
    }
}
