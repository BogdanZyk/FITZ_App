//
//  SettingsViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject{
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var settingItem: [SettingsItemModel] = []
    @Published var loginSingupPushed: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
    }
    
    func onAppear(){
        
       buildItems()
        
    }
    
    
    
    func tappedItem(_ item: SettingsItemModel){
        switch item.type{
            
        case .account:
            guard userService.currentUser?.email == nil else {return}
            loginSingupPushed.toggle()
        case .mode:
            DispatchQueue.main.async {
                self.isDarkMode.toggle()
                self.buildItems()
            }
            
        case .privacy:
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
            .init(title: userService.currentUser?.email ?? "Create Acount", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "\(isDarkMode ? "lightbulb" : "lightbulb.fill")", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
        if userService.currentUser?.email != nil{
            settingItem.append(.init(title: "Logout", iconName: "arrowshape.turn.up.left.fill", type: .logout))
        }
    }
    
}
