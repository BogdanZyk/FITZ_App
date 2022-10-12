//
//  TabContainerView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

struct TabContainerView: View {
    @EnvironmentObject var storeVM: StoreViewModel
    @StateObject private var tabVM = TabContainerViewModel()
    @StateObject private var challengeVM = ChallengeListViewModel()
    @State private var showCreateModal: Bool = false
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {

            TabView(selection: $tabVM.selectedTab){
                ForEach(tabVM.tabItem, id: \.self) { tab in
                    tabView(for: tab.type)
                        .tag(tab.type)
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                tabBarView
            }
        .accentColor(.primary)
        .sync($challengeVM.showCreateModal, with: $showCreateModal)
        .sheet(isPresented: $showCreateModal) {
            CreateChallengeModalView()
        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
            .environmentObject(StoreViewModel())
    }
}


extension TabContainerView{
    
    
    @ViewBuilder
    private func tabView(for tabItemType: TabItem.TabItemType) -> some View{
        switch tabItemType{
    
        case .challengeList:
            NavigationView {
                ChallengeListView()
            }
            .environmentObject(challengeVM)
            
        case .settings:
            NavigationView{
                ProfileView()
                    .environmentObject(storeVM)
            }
            .environmentObject(challengeVM)
        }
    }
    
    private func tabItem(for tab: TabItem) -> some View{
        Group{
            Image(systemName: tab.imageName)
            Text(tab.title)
        }
    }
    
}

extension TabContainerView{
    
    
    
    private var tabBarView: some View{
        HStack(spacing: 0){
            Spacer()
            tabButton(tab: tabVM.tabItem[0])
            Spacer()
            createChallengeBtn
            Spacer()
            tabButton(tab: tabVM.tabItem[1])
            Spacer()
        }
        .padding(.top, 10)
        .background(Material.ultraThinMaterial)
    }
    
    private func tabButton(tab: TabItem) -> some View{
        Image(systemName: tab.imageName)
            .font(.title2.bold())
            .foregroundColor(tabVM.selectedTab == tab.type ? .primaryFont : .secondary)
            .onTapGesture {
                tabVM.selectedTab = tab.type
            }
    }
    
    private var createChallengeBtn: some View{
        Button {
            challengeVM.send(.create)
        } label: {
            ZStack{
                Circle()
                    .fill(Color.createPrimaryBtn)
                Image(systemName: "plus")
                    .foregroundColor(.invertPrimaryFont)
                    .font(.title2.bold())
            }
            .frame(width: 50, height: 50)
            .shadow(color: .createPrimaryBtn.opacity(0.1), radius: 10, x: 0, y: 0)
        }
    }
}
