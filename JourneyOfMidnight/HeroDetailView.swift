//
//  HeroDetailView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/18.
//

import Foundation
import SwiftUI

// Hero Detail View
struct HeroDetailView: View {
    let hero: Hero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(hero.heroClass.name.rawValue)
                .font(.title)
                .fontWeight(.bold)
            
            Text("Level \(hero.heroClass.level)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Attributes
            Group {
                Text("Attributes")
                    .font(.headline)
                
                Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 5) {
                    GridRow {
                        Text("STR: \(hero.attributes.Strength)")
                        Text("INT: \(hero.attributes.Intelligence)")
                    }
                    GridRow {
                        Text("WIS: \(hero.attributes.Wisdom)")
                        Text("AGI: \(hero.attributes.Agility)")
                    }
                    GridRow {
                        Text("VIT: \(hero.attributes.Vitality)")
                        Text("FTH: \(hero.attributes.Faith)")
                    }
                    GridRow {
                        Text("CHA: \(hero.attributes.Charisma)")
                    }
                }
                .font(.caption)
            }
            
            // Skills
            Group {
                Text("Skills")
                    .font(.headline)
                
                ForEach(hero.skills) { skill in
                    HStack {
                        Text(skill.name)
                        Spacer()
                        Text("Power: \(skill.power)")
                    }
                    .font(.caption)
                }
            }
            
            // Items
            Group {
                Text("Items")
                    .font(.headline)
                
                HStack {
                    ForEach(hero.items) { item in
                        Text(item.name)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .font(.caption)
                    }
                }
            }
            
            // Stats
            Group {
                Text("Stats")
                    .font(.headline)
                
                HStack {
                    Text("Health: \(hero.stats.health)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(5)
                    
                    Text("Endurance: \(hero.stats.endurance)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(5)
                }
                .font(.caption)
            }
        }
        .padding()
    }
}

