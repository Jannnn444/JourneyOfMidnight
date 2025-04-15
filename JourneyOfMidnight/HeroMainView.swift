//
//  HeroMainView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/14.
//

import SwiftUI

struct HeroMainView: View {
    @ObservedObject var cardManager = CardManager.shared
    
    var body: some View {
        VStack {
            Text("Hero Main Page")
                .font(.title)
                .padding()
            
            // Cards Properties we can use
            /*
             Text("Hero name: \(cardManager.hero.heroClass.name.rawValue)")
             Text("Hero level: \(cardManager.hero.heroClass.level)")
             Text("Hero Attributes Charisma:  \(cardManager.hero.attributes.Charisma)")
             ForEach(cardManager.hero.skills) { skill in
             Text("Hero Skill: \(skill.name.capitalized)")
             }
             ForEach(cardManager.hero.items) { item in
             Text("Hero Skill: \(item.name.capitalized)")
             Text("Hero status: \(cardManager.hero.stats.health)")
             }
             */
            
            // Design the display cards
            HStack {
                ForEach(cardManager.hero) { hero in
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 130)
                            .foregroundColor(.yellow)
                            .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(hero.heroClass.name.rawValue)
                                .font(.subheadline)
                            Text("Level: \(hero.heroClass.level)")
                                .font(.subheadline)
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    HeroMainView()
}
