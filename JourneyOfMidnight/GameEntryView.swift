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
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.pink)
                // MARK: ⚔️BattleField >>> Story / Player
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.yellow)
                // MARK: ⚙️Settings
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    GameEntryView()
}
