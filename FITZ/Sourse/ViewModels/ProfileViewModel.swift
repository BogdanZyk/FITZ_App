//
//  ProfileViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI
import Combine

final class ProfileViewModel: ObservableObject{
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var currentUser: FitzUser?
    @Published private(set) var settingItem: [SettingsItemModel] = []
    @Published var loginSingupPushed: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
        getCurrentUser()
    }
    
    func onAppear(){
        buildItems()
    }
    
    var isPremium: Bool{
        userService.isPremium
    }
    
    var isAnonUser: Bool {
        userService.currentUser?.email == nil
    }
    
    
    func tappedItem(_ item: SettingsItemModel){
        switch item.type{
            
        case .mode:
            DispatchQueue.main.async {
                self.isDarkMode.toggle()
                self.buildItems()
            }
            
        case .privacy:
            break
        case .about:
            break
        case .logout:
            userService.logout()
                .sink { completion in
                    switch completion{
                    case .finished: break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { _ in}
                .store(in: &cancellables)
        }
    }
    
    private func buildItems() {
        settingItem = [
            .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "\(isDarkMode ? "lightbulb" : "lightbulb.fill")", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy),
            .init(title: "About us", iconName: "doc.plaintext", type: .privacy)
        ]
        if !isAnonUser{
            settingItem.append(.init(title: "Logout", iconName: "arrowshape.turn.up.left.fill", type: .logout))
        }
    }
    
    
    func getCurrentUser(){
        userService.getCurrentUser()
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { user in
                self.currentUser = user
            })
            .store(in: &cancellables)
    }
    
}
