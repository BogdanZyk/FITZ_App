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
    @StateObject private var apppState = AppState()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if apppState.isLoggedIn{
                TabContainerView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }else{
                LandingView()
            }
        }
    }
}



