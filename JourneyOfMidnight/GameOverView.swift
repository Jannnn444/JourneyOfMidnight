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
    @State var gameModelView = GameVIewModel()
    
    var body: some View {
        VStack {
            Text("The game is over!")
                .fontDesign(.monospaced)
                .font(.title)
                .bold()
                .padding()
            Text("Player strength\(gameModelView.player?.attributes.Strength ?? 0)")
                .fontDesign(.monospaced)
                .font(.caption)
                .bold()
                .padding()
            Text("Player Charisma\(gameModelView.player?.attributes.Charisma ?? 0)")
                .fontDesign(.monospaced)
                .font(.caption)
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
