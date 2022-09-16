//
//  TabContainerViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

final class TabContainerViewModel: ObservableObject{
    
    let tabItem = [
    
        TabItem(imageName: "book", title: "Activity log", type: .log),
        TabItem(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        TabItem(imageName: "gear", title: "Settings", type: .settings)
    
    ]
    
    @Published var selectedTab: TabItem.TabItemType = .challengeList
    
    
}
