//
//  Queue.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

struct QueueView: View {
    @Binding var navigation: Navigation
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            VStack {
                Text(" Game Lobby ")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundColor(.white)
                    .padding()
    
                Spacer()
                Text("Searching for other players...")
                    .fontDesign(.monospaced)
                    .foregroundColor(.white)
                    .padding()
                
                // When connected, popped into game mode
                
                Button(action: {
                    navigation = .home
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
               
            }
            
        }
    }
}

