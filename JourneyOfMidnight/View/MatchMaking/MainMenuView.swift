//
//  MainMenu.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

enum Navigation {
    case home
    case game
    case queue
    case settings
}

struct MainMenuView: View {
    @ObservedObject var cardManager = CardManager.shared
    @ObservedObject var websocketManager = WebSocketManager.shared
    
    @AppStorage("selectedAppColor") private var selectedColorName = "black"
    
    @State private var navigation: Navigation = .home
    
    // Event state and player resources
    @State private var eventState: Events = .combat
    @State private var gold: Gold = Gold(gold: 10000)
    @State private var stories: [Story] = []
    
    // State for popup views
    @State private var selectedHeros: [Hero] = []
    @State private var selectedEnemies: [Hero] = []
    @State private var selectedItems: [VendorGoods] = []
    
    @State private var showDetailSkillViewHero: Bool = false
    @State private var showDetailSkillViewEnemi: Bool = false
    @State private var showDetailItemView: Bool = false
    
    @State private var showMoreDetailHero: Bool = false
    @State private var showMoreDetailEnemi: Bool = false
    @State private var showMoreDetailItems: Bool = false
    
    var body: some View {
        ZStack {
            // Background image for the entire app
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            switch navigation {
            case .home:
                VStack {
                    Spacer()
                    
                    // Title with logo
//                    Image("banner")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 400)
//                        .padding(.bottom, 40)
                    
                    Text("Journey Of Midnight")
                        .font(.largeTitle)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fromHex(selectedColorName).opacity(0.6))
                        .cornerRadius(10)
                        .padding(.bottom, 60)
                    
                    // Main menu buttons
                    VStack(spacing: 20) {
                        Button(action: {
                            // Prepare needed data before starting game
                            eventState = .combat
                            stories = cardManager.stories
                            navigation = .game
                        }) {
                            MenuButton(text: "Start Adventure", icon: "gamecontroller")
                        }
                        
                        Button(action: {
                            navigation = .queue
//                          websocketManager.connect() 
                            // MARK: here put func
                            setupWebsocketConnection()
                        }) {
                            MenuButton(text: "Find Match", icon: "magnifyingglass")
                        }
                        
                        Button(action: {
                            navigation = .settings
                        }) {
                            MenuButton(text: "Settings", icon: "gearshape")
                        }
                    }
                    
                    Spacer()
                    
                    // Credits text
                    Text("Created by Yucian Huang © 2025")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding()
                }.padding()
                
            case .game:
                // Show the appropriate event screen based on eventState
                Group {
                    switch eventState {
                    case .combat:
                        ZStack {
                            // Main event screen
                            EventScreenTemplate(
                                eventState: $eventState,
                                gold: $gold,
                                selectedEnemies: $selectedEnemies,
                                showDetailSkillViewEnemi: $showDetailSkillViewEnemi,
                                showMoreDetailEnemi: $showMoreDetailEnemi
                            )
                            
                            // Additional hero popup that needs to be at the ZStack level
                            CardHeroSetViewWSkill(
                                selectedHeros: $selectedHeros,
                                showDetailSkillView: $showDetailSkillViewHero,
                                showMoreDetail: $showMoreDetailHero
                            )
                        }
                        
                    case .vendor:
                        ZStack {
                            EventScreenTemplate(
                                eventState: $eventState,
                                gold: $gold,
                                selectedItems: $selectedItems,
                                showDetailItemView: $showDetailItemView,
                                showMoreDetailItems: $showMoreDetailItems
                            )
                            
                            // Additional hero popup that needs to be at the ZStack level
                            CardHeroSetViewWSkill(
                                selectedHeros: $selectedHeros,
                                showDetailSkillView: $showDetailSkillViewHero,
                                showMoreDetail: $showMoreDetailHero
                            )
                        }
                        
                    case .inTheWoods:
                        ZStack {
                            EventScreenTemplate(
                                eventState: $eventState,
                                gold: $gold,
                                stories: $stories
                            )
                            
                            // Additional hero popup that needs to be at the ZStack level
                            CardHeroSetViewWSkill(
                                selectedHeros: $selectedHeros,
                                showDetailSkillView: $showDetailSkillViewHero,
                                showMoreDetail: $showMoreDetailHero
                            )
                        }
                    }
                }
                
                // Add back button to return to main menu
                VStack {
                    HStack {
                        Button(action: {
                            navigation = .home
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Main Menu")
                                    .fontDesign(.monospaced)
                                    .fontWeight(.bold)
                            }
                            .padding(10)
//                            .background(Color.black.opacity(0.7))
                            .background(Color.fromHex(selectedColorName).opacity(0.6)
                            .foregroundColor(.white))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    Spacer()
                }
                
            case .queue:
                // Queue view
                ZStack {
                    VStack {
                        if websocketManager.isConnected {
                            QueueView(navigation: $navigation)
                            
                        } else {
                            Text("Cannot connect to server")
                                .font(.headline.bold())
                                .foregroundColor(.red)
                                .padding()
                            HStack {
                                Button("Retry") {
                                    websocketManager.connect()
                                }
                                .padding()
                                .background(Color.fromHex(selectedColorName).opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                                Button("Back") {
                                    navigation = .home
                                }
                                .padding()
                                .background(Color.fromHex(selectedColorName).opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .frame(width: 500, height: 300)
                .cornerRadius(20)
                
            case .settings:
                ZStack {
                    SettingMainView().ignoresSafeArea()
                        
                    // Add back button for settings
                    VStack {
                        HStack {
                            Button(action: {
                                navigation = .home
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                }
                                .padding(10)
                                .background(Color.fromHex(selectedColorName).opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                    
                           
                        }
                      
                    }.ignoresSafeArea()
                }
            }
        }
        .onAppear {
            // Make sure we have stories loaded when the view appears
            if stories.isEmpty {
                stories = cardManager.stories
            }
        }
        .onChange(of: websocketManager.queueStatus) { status in
            handleQueueStatusChange(status)
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Queue Status Handling
    private func handleQueueStatusChange(_ status: WebSocketManager.QueueStatus) {
        switch status {
        case .waiting:
            print("Waiting for players...")
            
        case .found:
            print("Match found! Preparing to start game...")
            // Show match found notification
            showMatchFoundAlert()
            
        case .starting:
            print("Game is starting...")
            // Optional: Show countdown or loading screen
            
        case .inGame:
            print("Starting multiplayer game...")
            startMultiplayerGame()
        }
    }
    private func startMultiplayerGame() {
        // Set up game state for multiplayer
        eventState = .combat
        stories = cardManager.stories
        
        // Store multiplayer game info for use in game
        // You might want to pass gameId and players to your EventScreenTemplate
        
        // Transition to game
        navigation = .game
        
        print("🚀 Multiplayer game started!")
        print("Game ID: \(websocketManager.gameId ?? "Unknown")")
        print("Players: \(websocketManager.currentPlayers)")
    }

    private func showMatchFoundAlert() {
        // You can add a custom alert/notification here
        print("🎮 Match Found!")
        print("Players: \(websocketManager.currentPlayers)")
        print("Game ID: \(websocketManager.gameId ?? "Unknown")")
        
        // Automatically proceed to game after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            websocketManager.confirmGameStart()
        }
    }
    
    private func setupWebsocketConnection() {
        websocketManager.connect()
        Task {
            // Wait 2 seconds
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            // Check connection on main actor
            await MainActor.run {
                if websocketManager.isConnected {
                    print("WebSocket connected! Finding match...")
                    websocketManager.findMatch(username: "PlayerOfC")
                } else {
                    print("WebSocket not connected after 2 seconds")
                }
            }
        }
        /*
        -
        asyncAfter + 2.0
        -
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if websocketManager.isConnected {
                print("WebSocket connected! Finding match...")
                WebSocketManager.shared.findMatch(username: "Player1")
            } else {
                print("WebSocket faield connected ...")
            }
        }
        */
        
    }
}

// Helper view for menu buttons
struct MenuButton: View {
    let text: String
    let icon: String
    @AppStorage("selectedAppColor") private var selectedColorName = "black"
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
                .fontDesign(.monospaced)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 30)
//      .background(Color.black.opacity(0.7))
        .background(Color.fromHex(selectedColorName).opacity(0.6))
        .foregroundColor(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

// Preview provider
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
