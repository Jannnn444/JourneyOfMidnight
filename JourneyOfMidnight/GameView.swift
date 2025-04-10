//
//  GameView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/8.
//

import Foundation
import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameVIewModel()
    @State var isGameOver: Bool = false
    
    var body: some View {
        VStack {
            // Display the current occasion
            if viewModel.level < viewModel.occasions.count {
                let currentOccasion = viewModel.occasions[viewModel.level]
                
                Text(currentOccasion.topic)
                    .font(.title)
                    .bold()
                    .padding()
                
                Text(currentOccasion.description)
                    .padding()
                
                // Display choices
                ForEach(currentOccasion.choices, id: \.text) { choice in
                    
                    Button(action: {
                        Task {
                           await viewModel.choose(choice)
                        }
                    }) {
                        Text(choice.text)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(2)
                }
            }
        }
        .onAppear {
            //MARK: - init the datas!
            viewModel.setupOccasions()
            viewModel.setupPlayerData()
        }
        .onChange(of: viewModel.level) { newLevel in
            // Check if the game is over
            if newLevel == viewModel.occasions.count - 1 {
                isGameOver = true
            }
        }
        .fullScreenCover(isPresented: $isGameOver) {
            GameOverView(restartAction: {
                viewModel.restartGame()
                isGameOver = false  // Close the GameOver screen
            })
        }
    }
}
