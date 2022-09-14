//
//  FITZApp.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.09.2022.
//

import SwiftUI

@main
struct FITZApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}



