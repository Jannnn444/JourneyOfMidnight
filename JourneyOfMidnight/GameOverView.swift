//
//  GameOverView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/8.
//

import SwiftUI

struct GameOverView: View {
    var restartAction: () -> Void
    @ObservedObject var gameModelView : GameVIewModel // ! Pass in old model
    @State private var showGameEntryVIew = false
    
    var currentAttributes: Attributes {
        gameModelView.player?.attributes ?? Attributes()
    }
    
    var body: some View {
        VStack {
            Text("The game is over!")
                .fontDesign(.monospaced)
                .font(.title)
                .bold()
                .padding()
            Text("Player strength\(currentAttributes.Strength)")
                .fontDesign(.monospaced)
                .font(.caption)
                .bold()
                .padding()
            Text("Player Charisma\(currentAttributes.Charisma)")
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
