//
//  TabContainerView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

struct TabContainerView: View {
    @StateObject private var tabVM = TabContainerViewModel()
    var body: some View {
        TabView(selection: $tabVM.selectedTab){
            ForEach(tabVM.tabItem, id: \.self) { tab in
                tabView(for: tab.type)
                    .tabItem{
                        tabItem(for: tab)
                    }
                    .tag(tab.type)
            }
        }
        .accentColor(.primary)
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}


extension TabContainerView{
    
    
    @ViewBuilder
    private func tabView(for tabItemType: TabItem.TabItemType) -> some View{
        switch tabItemType{
        case .log:
            Text("Log")
        case .challengeList:
            Text("Challenge List")
        case .settings:
            Text("Settings")
        }
    }
    
    private func tabItem(for tab: TabItem) -> some View{
        Group{
            Image(systemName: tab.imageName)
            Text(tab.title)
        }
    }
    
}
