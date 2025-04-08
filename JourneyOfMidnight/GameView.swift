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

    var body: some View {
        VStack {
            // Display the current occasion
            if viewModel.level < viewModel.occasions.count {
                let currentOccasion = viewModel.occasions[viewModel.level]
                
                Text(currentOccasion.title)
                    .font(.title)
                    .bold()
                    .padding()
                
                Text(currentOccasion.description)
                    .padding()
                
                // Display choices
                ForEach(currentOccasion.choices, id: \.text) { choice in
                    Button(action: {
                        viewModel.choose(choice)
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
            
            if viewModel.level == viewModel.occasions.count - 1 {
                Text("The game is over!")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            viewModel.setupOccasions() //init the datas!
        }
    }
}
