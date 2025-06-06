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
    
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .tint(Color.fromHex(storedColor)) // Apply to entire app
                .onAppear {
                    MusicManager.shared.playBacjgroundMusic(fileName: "Maple")
                }
        }
    }
}

