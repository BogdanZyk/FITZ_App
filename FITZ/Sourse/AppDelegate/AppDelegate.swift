//
//  AppDelegate.swift
//  FITZ
//
//  Created by Bogdan Zykov on 15.09.2022.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    firebaseAuthGroup()
    return true
  }
}
