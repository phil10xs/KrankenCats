//
//  KrankenCatsApp.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import SwiftUI

@main
struct KrankenCatsApp: App {
    var body: some Scene {
        WindowGroup {
                  BreedsView(vm:BreedsViewModel())
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
        return true
    }
}
