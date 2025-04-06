//
//  GameEntryView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/6.
//

import Foundation
import SwiftUI

// Notes: Make this main view on maion entry view!
struct GameEntryView: View {
    var body: some View {
        VStack {
            Text("Entry View")
                .font(.title)
                .fontDesign(.monospaced)
                .bold()
            HStack {
                // TBD: Make Rectangles Clickable Buttons
                // MARK: 🃏MyCards
                ZStack {
                    Rectangle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.pink)
                    Text("Cards")
                        .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                }
                // MARK: ⚔️BattleField >>> Story / Player
                ZStack {
                    Rectangle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.yellow)
                    Text("Battle")
                        .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                }
                // MARK: ⚙️Settings
                ZStack {
                    Rectangle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.blue)
                    Text("Settings")
                        .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                }
            }
        }
    }
}

#Preview {
    GameEntryView()
}
