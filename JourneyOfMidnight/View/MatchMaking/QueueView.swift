//
//  Queue.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

struct QueueView: View {
    @Binding var navigation: Navigation
    @ObservedObject var cardManager = CardManager.shared
    @ObservedObject var websocketManager = WebSocketManager.shared
    @ObservedObject var musicManager = MusicManager.shared
    
    @AppStorage("selectedAppColor") private var selectedColorName = "black"
    @State private var showPlayerInfo: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                Text("  ") // Game Lobby
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                // MARK: QUEUE ! show alarm text
                
                // CHECK BY IF ELSE
                
//                if websocketManager.currentPlayers.count == 1 {
//                    Text("You are next")
//                        .padding()
//                        .font(.headline.bold())
//                        .foregroundColor(.black)
//                        .background(Color.white.opacity(0.6))
//                        .cornerRadius(12)
//                        .padding()
//                } else if websocketManager.currentPlayers.count == 2 {
//                    VStack{
//                        Text("Congrats! You found match! \nReady to fight? :)")
//                            .lineLimit(nil)
//                            .padding()
//                            .font(.headline.bold())
//                            .foregroundColor(.black)
//                            .background(Color.white.opacity(0.6))
//                            .cornerRadius(12)
//                            .padding()
//                        HStack {
////                            Button("Yes") {
////                                // action to yes
////                                // when yes -> go to game
////                                EventCombat()
////                            } .padding()
////                                .background(Color.fromHex(selectedColorName).opacity(0.6))
////                                .foregroundColor(.white)
////                                .cornerRadius(10)
////                            Button("No") {
////                                // action to no
////                                // back to main!
////                                navigation = .home
////                            } .padding()
////                                .background(Color.fromHex(selectedColorName).opacity(0.6))
////                                .foregroundColor(.white)
////                                .cornerRadius(10)
////                            // back menu
////                            Button("Back") {
////                                navigation = .home
////                                websocketManager.currentPlayers = []
////                            }
////                            .padding()
////                            .background(Color.fromHex(selectedColorName))
////                            .foregroundColor(.white)
////                            .cornerRadius(10)
//                        }.padding()
//                    } // count == 2
//                } else if websocketManager.currentPlayers.count == 3 {
//                    Text("Queuing: Short waiting ! ")
//                        .padding()
//                        .font(.headline.bold())
//                        .foregroundColor(.black)
//                        .background(Color.white.opacity(0.6))
//                        .cornerRadius(12)
//                        .padding()
//                } else if websocketManager.currentPlayers.count == 4 {
//                    Text("Queuing: Short waiting ! ")
//                        .padding()
//                        .font(.headline.bold())
//                        .foregroundColor(.black)
//                        .background(Color.white.opacity(0.6))
//                        .cornerRadius(12)
//                        .padding()
//                } else if websocketManager.currentPlayers.count >= 5 {
//                    Text("Queuing: Medium waiting ! ")
//                        .padding()
//                        .font(.headline.bold())
//                        .foregroundColor(.black)
//                        .background(Color.white.opacity(0.6))
//                        .cornerRadius(12)
//                        .padding()
//                }

                Spacer()
                
                // Queue Status Display
                VStack(spacing: 15) {
                    switch websocketManager.queueStatus {
                    case .waiting:
                        
                        Text("Searching for other players...")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .padding()
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
                    
                    // Player Info (shown after 3 seconds, by onAppear)
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
                        .onAppear {  // Inside the if block
                               websocketManager.queueStatus = .found
                        }
                    }
                }
                
                Spacer()
                
               
            }
        }
        .onAppear {
            // Show player info after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.6)) {
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
