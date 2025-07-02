//
//  HeroOptionsView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/30.
//

import Foundation
import SwiftUI

struct HeroOptionsView: View {
    var hero: Hero
    @State var selectedItem: Item?
    @State var selectedSkill: Skill?
    @ObservedObject var cardManager = CardManager.shared
    
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8)
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            // Hero Header
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 70, height: 70)
                    Image(heroImage(for: hero.heroClass.name))
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(hero.heroClass.name.rawValue.capitalized)
                            .foregroundStyle(.white)
                            .fontDesign(.monospaced)
                            .font(.headline)
                            .bold()
                        
                        Text("Lv.\(hero.heroClass.level)")
                            .foregroundStyle(.yellow)
                            .fontDesign(.monospaced)
                            .font(.subheadline)
                            .bold()
                    }
                    
                    Text("Edit your gears & abilities!")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.caption)
                }
                Spacer()
            }
            
            // Combined Equipment & Skills Grid
            VStack(spacing: 4) {
                Text("Equipment & Abilities:")
                    .foregroundStyle(.white)
                    .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                
                LazyVGrid(columns: columns, spacing: 6) {
                    // Create 10 slots (2 rows x 5 columns)
                    ForEach(0..<10, id: \.self) { index in
                        ZStack {
                            // Background slot
                            Rectangle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.black.opacity(0.9))
                                .border(.gray, width: 2)
                            
                            // Items first, then skills
                            if index < hero.items.count {
                                // Show item
                                Button(action: {
                                    selectedItem = hero.items[index]
                                    selectedSkill = nil // Clear skill selection
                                }) {
                                    Image(hero.items[index].name)
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                }
                            } else if (index - hero.items.count) < hero.skills.count {
                                // Show skill
                                let skillIndex = index - hero.items.count
                                let currentSkill = hero.skills[skillIndex]
                                Button(action: {
                                    selectedSkill = currentSkill
                                    selectedItem = nil // Clear item selection
                                }) {
                                    ZStack {
                                        // Skill background with different color
                                        Circle()
                                            .fill(Color.white.opacity(0.5))
                                            .frame(width: 35, height: 35)
                                        
                                        // Use skill name for image, with fallback
                                        Image("\(skillImage(for: currentSkill.name))")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 6)
            }
            
            // Show selected item or skill info
            if let selectedItem = selectedItem {
                VStack(spacing: 2) {
                    Text("Selected Item: \(selectedItem.name)")
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text(selectedItem.intro)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(4)
            } else if let selectedSkill = selectedSkill {
                VStack(spacing: 2) {
                    Text("Selected Skill: \(selectedSkill.name)")
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text("Power: \(selectedSkill.power)")
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.blue)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(4)
            }
        }
        .frame(maxWidth: 380, maxHeight: 250)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

private func heroImage(for heroClass: HeroClassName) -> String {
    switch heroClass {
       case .fighter: return "knight"
       case .wizard: return "princess"
       case .priest: return "priest"
       case .duelist: return "duelist"
       case .rogue: return "king"
       case .templar: return "templar"
   }
}

private func skillImage(for skillName: String) -> String {
    switch skillName.lowercased() {
        case "meteor": return "Meteor"
        case "dodge": return "dodge"
        case "rainy": return "Rainy"
        case "wolve": return "Meow"
        case "flower": return "Flower"
        case "wolvecry": return "WolveCry"
        case "moon": return "Moon"
        case "meow": return "meow"
        case "lightling": return "lightling"
        case "holy": return "Holy"
        case "god": return "god"
        case "gun": return "gun"
        case "fist": return "fist"
        default: return "defaultSkill" // fallback image
    }
}
