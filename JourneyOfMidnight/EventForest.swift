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
    
    var body: some View {
        Rectangle()
            .frame(width: 500, height: 350)
            .foregroundColor(.green.opacity(0.8))
            .cornerRadius(20)
        Image("banner")
            .frame(width: 400, height: 200)
            .padding()
        VStack {
            HStack {
                Image("forest")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Adventure Forest")
                    .font(.title)
                    .bold()
                    .fontDesign(.monospaced)
                    .foregroundStyle(.black)
            } .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
          /*  Spacer()*/ // push the banner up
            
            VStack(alignment: .center) {
            if !cardManager.stories.isEmpty {
                // Current Story Display
                let currentStory = cardManager.stories[selectedStoryIndex]
                
                // Story text
                Text(currentStory.topic)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                // Options
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
                                
                                // Effect badge
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
            } else {
                Text("No adventures available")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(8)
            }
            }   .frame(width: 500, height: 500)
                .position(x: 420, y: 150)
                
                         // Story navigation (if you have multiple stories)
                         if cardManager.stories.count > 1 {
                             HStack(spacing: 20) {
                                 Button(action: {
                                     selectedStoryIndex = max(0, selectedStoryIndex - 1)
                                 }) {
                                     Image(systemName: "arrow.left.circle.fill")
                                         .font(.title)
                                         .foregroundColor(.black)
                                 }
                                 .disabled(selectedStoryIndex == 0)
                                 
                                 Button(action: {
                                     selectedStoryIndex = min(cardManager.stories.count - 1, selectedStoryIndex + 1)
                                 }) {
                                     Image(systemName: "arrow.right.circle.fill")
                                         .font(.title)
                                         .foregroundColor(.black)
                                 }
                                 .disabled(selectedStoryIndex == cardManager.stories.count - 1)
                             }
                         }
                     }
                 }
            
             
             // Helper function to handle option selection
             private func handleOptionSelected(option: Option) {
                 // Here you would implement the logic for when a player selects an option
                 // For example, updating character stats, progressing the story, etc.
                 print("Selected option: \(option.option) with effect: +\(option.effect) \(option.effectType)")
                 
                 // Move to the next story or show results
                 if selectedStoryIndex < cardManager.stories.count - 1 {
                     selectedStoryIndex += 1
                 } else {
                     // End of stories - implement your game logic here
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

      
