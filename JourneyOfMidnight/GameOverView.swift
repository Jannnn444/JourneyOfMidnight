//
//  GameOverView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/8.
//

import SwiftUI

struct GameOverView: View {
    var restartAction: () -> Void
    
    var body: some View {
        VStack {
            Text("The game is over!")
                .font(.title)
                .bold()
                .padding()
            Button("Restart") {
                restartAction()
            }
            .padding()
        }
    }
}
