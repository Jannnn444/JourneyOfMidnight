//
//  Queue.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

struct QueueView: View {
    @Binding var navigation: Navigation
    @ObservedObject var websocketManager = WebSocketManager.shared
    
    @State private var showPlayerInfo: Bool = false
    
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
                
                // Queue Status Display
                VStack(spacing: 15) {
                    switch websocketManager.queueStatus {
                    case .waiting:
                        Text("Searching for other players...")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .padding()
                        
                    case .found:
                        VStack(spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.title)
                            Text("Match Found!")
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(.green)
                                .padding()
                            Text("Starting game...")
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                        }
                        
                    case .starting:
                        VStack(spacing: 10) {
                            Text("Game Starting...")
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(.yellow)
                                .padding()
                            Text("Prepare for battle!")
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                        }
                        
                    case .inGame:
                        Text("In Game")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    // Player Info (shown after 2 seconds)
                    if showPlayerInfo {
                        VStack(spacing: 10) {
                            Text("Players in queue: \(websocketManager.currentPlayers.count)/2")
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                                .padding()
                            
                            // Player List
                            if !websocketManager.currentPlayers.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(websocketManager.currentPlayers, id: \.self) { player in
                                        HStack {
                                            Image(systemName: "person.fill")
                                                .foregroundColor(.blue)
                                            Text(player)
                                                .fontDesign(.monospaced)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(10)
                            }
                            
                            // Game ID (if available)
                            if let gameId = websocketManager.gameId {
                                Text("Game ID: \(gameId)")
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.gray)
                                    .padding(.top)
                            }
                        }
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                
                Spacer()
                
                // Cancel Button
                Button(action: {
                    navigation = .home
                    websocketManager.cancelQueue()
                    websocketManager.disconnect()
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            // Show player info after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showPlayerInfo = true
                }
            }
        }
        .onDisappear {
            // Reset state when leaving the view
            showPlayerInfo = false
        }
    }
}
