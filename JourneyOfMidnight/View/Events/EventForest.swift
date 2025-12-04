//
//  EventForest.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import SwiftUI

struct EventForest: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var stories: [Story]
    @State private var selectedStoryIndex = 0
    @State private var showOptions = false // Add this state variable
    @State private var showTopic = true
    
    var body: some View {
        VStack {
            HStack {
                Image("forest")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Adventure Forest")
                    .font(.caption)
                    .bold()
                    .fontDesign(.monospaced)
                    .foregroundStyle(.black)
            } .padding()
              .cornerRadius(10)
            
            VStack(alignment: .leading) {
                if !cardManager.stories.isEmpty {
                    let currentStory = cardManager.stories[selectedStoryIndex]
                    
                    Button(action: {
                        showOptions.toggle()
                        showTopic.toggle()
                    }) {
                        if showTopic {
                            Text(currentStory.topic)
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(8)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    if showOptions {
                        VStack() {
                            ForEach(currentStory.choice) { option in
                                Button(action: {
                                    handleOptionSelected(option: option)
                                }) {
                                    HStack {
                                        Text(option.option)
                                            .font(.subheadline)
                                            .foregroundStyle(.black)
                                            .fontDesign(.monospaced)
                                            .bold()
                                        Spacer()
                                        HStack(spacing: 4) {
                                            Text("+\(option.effect)")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                            
                                            Text(option.effectType.rawValue)
                                                .font(.caption)
                                                .foregroundStyle(.white)
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(effectColor(for: option.effectType))
                                        .cornerRadius(12)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(8)
                                }
                            }
                        }
                        
                        .padding(.horizontal)
                        .transition(.opacity) // Optional: add a transition effect
                    }
                } else {
                    Text("No adventures available")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)
                }
            }
            .frame(width: 500, height: 500)
            .position(x: 420, y: 80) // located the topic area
            
            // Story navigation
            HStack(spacing: 20) {
                Button(action: {
                    selectedStoryIndex = max(0, selectedStoryIndex - 1)
                    resetOptionState()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .disabled(selectedStoryIndex == 0)
                
                Button(action: {
                    selectRandomStory()
                    resetOptionState()
                }) {
                    Image(systemName: "dice.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                }
                //                    .disabled(selectedStoryIndex == cardManager.stories.count - 1)
                .disabled(cardManager.stories.count <= 1 )
                
                Button(action: {
                    selectedStoryIndex = min(cardManager.stories.count - 1, selectedStoryIndex + 1)
                    resetOptionState()
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .disabled(selectedStoryIndex == cardManager.stories.count - 1)
            }
            .padding(.top,20)
        } .onAppear {
            
            selectRandomStory()  // Get a random story when the view first appears
        }
    }
    
    private func selectRandomStory() {
        if let randomIndex = cardManager.stories.indices.randomElement() {
            selectedStoryIndex = randomIndex
        }
    }
    // Reset options state when changing stories
    private func resetOptionState() {
        showOptions = false
        showTopic = true
    }
    
    // Helper function to handle option selection
    private func handleOptionSelected(option: Option) {
        // Here you would implement the logic for when a player selects an option
        // For example, updating character stats, progressing the story, etc.
        print("Selected option: \(option.option) with effect: +\(option.effect) \(option.effectType)")
        // MARK: - this could shows on UI!!!
        // MARK: - Change the story show only once??
  
        // After handling the option, select a new random story
        selectRandomStory()
        
        // Reset UI state
        resetOptionState()
    }
    
}

// Helper function to provide appropriate colors for different effect types
private func effectColor(for effectType: EffectTypes) -> Color {
    switch effectType {
    case .Strength:
        return Color.red
    case .Intelligence:
        return Color.blue
    case .Wisdom:
        return Color.purple
    case .Agility:
        return Color.green
    case .Vitality:
        return Color.orange
    case .Faith:
        return Color.yellow
    case .Charisma:
        return Color.pink
    }
}

// Extension to make EffectTypes raw value accessible
extension EffectTypes: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        switch rawValue {
        case "Strength": self = .Strength
        case "Intelligence": self = .Intelligence
        case "Wisdom": self = .Wisdom
        case "Agility": self = .Agility
        case "Vitality": self = .Vitality
        case "Faith": self = .Faith
        case "Charisma": self = .Charisma
        default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .Strength: return "STR"
        case .Intelligence: return "INT"
        case .Wisdom: return "WIS"
        case .Agility: return "AGI"
        case .Vitality: return "VIT"
        case .Faith: return "FTH"
        case .Charisma: return "CHA"
        }
    }
}



