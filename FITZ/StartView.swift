//
//  StartView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.10.2022.
//

import SwiftUI

struct StartView: View {
    @StateObject private var storeViewModel = StoreViewModel()
    @StateObject private var appState = AppState()
    @State private var isActive: Bool = false
    var body: some View {
        Group{
            if isActive{
                if appState.isLoggedIn{
                    TabContainerView()
                        .environmentObject(storeViewModel)
                }else{
                    LandingView()
                }
            }else{
                LaunchScreenView(isActive: $isActive)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(StoreViewModel())
    }
}
