//
//  GameOverView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/8.
//

import SwiftUI

struct GameOverView: View {
    var restartAction: () -> Void
    @State private var showGameEntryVIew = false
    
    var body: some View {
        VStack {
            Text("The game is over!")
                .font(.title)
                .bold()
                .padding()
            HStack {
                Button("Restart") {
                    restartAction()
                }
                Button("Menu") {
                    showGameEntryVIew = true
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showGameEntryVIew) {
            GameEntryView()
        }
    }
}
