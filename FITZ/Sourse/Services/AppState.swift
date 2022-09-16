//
//  AppState.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import Foundation


final class AppState: ObservableObject{
    @Published private(set) var isLoggedIn = false
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
        userService
            .observedAuthChanges()
            .map({$0 != nil })
            .assign(to: &$isLoggedIn)
    }
    
    
}
