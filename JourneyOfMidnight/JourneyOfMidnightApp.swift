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
    var body: some Scene {
        WindowGroup {
            HeroMainView(eventState: .combat, gold: Gold(gold: 10000))
        }
    }
}
