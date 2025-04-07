//
//  GameEntryView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/6.
//

import Foundation
import SwiftUI

// Notes: Make this main view on main entry view!
struct GameEntryView: View {
    @State private var showPersonalView = false
    @State private var showBattleView = false
    @State private var showStoryView = false
    
    var body: some View {
        VStack {
            Text("Entry View")
                .font(.title)
                .fontDesign(.monospaced)
                .bold()
            HStack {
                // MARK: - 🃏MyCards
                Button(action: {
                    showPersonalView = true
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.pink)
                            .cornerRadius(10)
                        Text("Cards")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    }
                }
                .fullScreenCover(isPresented: $showPersonalView) {
                    PersonalView()
                }
                
                // MARK: - ⚔️Story
                Button(action: {
                    showBattleView = true
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.yellow)
                            .cornerRadius(10)
                        Text("Story")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    }
                }.fullScreenCover(isPresented: $showStoryView) {
                    StoryView()
                }
                
                // MARK: - ⚔️BattleField
                Button(action: {
                    showBattleView = true
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                        Text("Battle")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    }
                }.fullScreenCover(isPresented: $showBattleView ) {
                    BattleView()
                }
                
                // MARK: - ⚙️Settings
                Button(action: {
                    // Settings View
                }, label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        Text("Settings")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    }
                })
            }
        }
    }
}

#Preview {
    GameEntryView()
}
