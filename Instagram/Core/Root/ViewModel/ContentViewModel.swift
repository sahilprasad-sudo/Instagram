//
//  ContentViewModel.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import Foundation
import Combine
import FirebaseAuth

@MainActor
class ContentViewModel:ObservableObject{

    private let service = AuthService.shared
    
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser:User?
    
    private var cancellables =  Set<AnyCancellable>()
    
    init(){
        setupSubscribers()
    }
    
//    func setupSubscribers(){
//        service.$userSession.sink { [weak self] userSession in
//            self?.userSession = userSession
//        }
//    }
    func setupSubscribers() {
        service.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
        
        service.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
    }
    

}
