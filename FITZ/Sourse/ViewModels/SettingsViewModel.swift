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
    
    func onAppear(){
       buildItems()
    }
    
    
    
    func tappedItem(_ item: SettingsItemModel){
        switch item.type{
            
        case .account:
            break
        case .mode:
            isDarkMode.toggle()
            buildItems()
        case .privacy:
            break
        }
    }
    
    private func buildItems() {
        settingItem = [
            .init(title: "Create Acount", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "\(isDarkMode ? "lightbulb" : "lightbulb.fill")", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
    }
    
}
