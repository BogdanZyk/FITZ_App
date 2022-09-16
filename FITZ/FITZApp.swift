//
//  FITZApp.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.09.2022.
//

import SwiftUI

@main
struct FITZApp: App {
    @StateObject private var apppState = AppState()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if apppState.isLoggedIn{
                TabView{
                    Text("Log")
                    
                        .tabItem {
                            Image(systemName: "book")
                        }
                }.accentColor(.primary)
            }else{
                LandingView()
            }
        }
    }
}



