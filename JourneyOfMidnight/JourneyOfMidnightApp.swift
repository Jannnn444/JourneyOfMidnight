//
//
//  JourneyOfMidnightApp.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import SwiftUI

@main
struct JourneyOfMidnightApp: App {
    @AppStorage("selectedAppColor") private var storedColor = "black"
    @StateObject private var authViewModel = AuthViewModel()  
    // ✅ Create it here with @StateObject, You can't use @ObservedObject in the App struct! You need to use @StateObject to create and own the AuthViewModel instance at the app level.
    
    var body: some Scene {
        WindowGroup {
            MainMenuView(authViewModel: authViewModel)
                .tint(Color.fromHex(storedColor)) // Apply to entire app
                .onAppear {
//                    MusicManager.shared.playBackgroundMusic(fileName: "Maple")
                }
        }
    }
}

