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
    
    var body: some View {
        VStack {
            Text("The game is over!")
                .fontDesign(.monospaced)
                .font(.title)
                .bold()
                .padding()
            if let attributes = gameModelView.player?.attributes {
                Text("Player Strength \(attributes.Strength )")
                    .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                    .padding()
                Text("Player Charisma \(attributes.Charisma)")
                     .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                    .padding()
            } else {
                Text("No hero data")
                    .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                    .padding()
            }
           
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
