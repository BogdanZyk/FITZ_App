//
//  FITZApp.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.09.2022.
//

import SwiftUI

@main
struct FITZApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var appState = AppState()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            Group{
                if appState.isLoggedIn{
                    TabContainerView()
                }else{
                    LandingView()
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}



