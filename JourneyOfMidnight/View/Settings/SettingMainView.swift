//
//  SettingMainView.swift
//  JourneyOfMidnight
//
//  Created by Jan on 2025/6/5.
//

import Foundation
import SwiftUI

struct SettingMainView: View {
    @ObservedObject var musicManager = MusicManager.shared
//  @State private var isMusicEnabled = true
//  @State private var showSettings = false //when its false, go to mainpage (how)
    
    var body: some View {
        ZStack {
            // Background with better visual hierarchy
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    // Close button
                    Button(action: {
//                        showSettings = false
                        musicManager.showSettings = false
                        
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                // Settings Content
                VStack(spacing: 25) {
                    
                    // Music Settings Section
                    settingsSection {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Background Music")
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.white)
                                
                                Text("Toggle game soundtrack")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $musicManager.isMusicEnabled)
                                .toggleStyle(SwitchToggleStyle(tint: .mint))
                        }
                    }
                    
                    // Additional settings sections can go here
                    settingsSection {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Sound Effects")
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.white)
                                
                                Text("Battle and UI sounds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: .constant(true))
                                .toggleStyle(SwitchToggleStyle(tint: .mint))
                        }
                    }
                    
                    settingsSection {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Notifications")
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.white)
                                
                                Text("Game events and updates")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: .constant(false))
                                .toggleStyle(SwitchToggleStyle(tint: .mint))
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20)
        }
        .onChange(of: musicManager.isMusicEnabled) { oldValue, newValue in
            handleMusicToggle(enabled: newValue)
        }
        .onAppear {
            // Initialize music state when view appears
            handleMusicToggle(enabled: musicManager.isMusicEnabled)
        }.padding()
    }
    
    // MARK: - Helper Views
    
    @ViewBuilder
    private func settingsSection<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
    
    // MARK: - Music Management
    
    private func handleMusicToggle(enabled: Bool) {
        if enabled {
            MusicManager.shared.playBackgroundMusic(fileName: "Maple")
        } else {
            MusicManager.shared.stopBackgroundMusic()
        }
    }
}

#Preview {
    SettingMainView()
}
