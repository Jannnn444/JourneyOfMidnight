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
        // Title
        Text("Hero Main Page")
        
        // Cards
        Text("Hero name: \(cardManager.hero.heroClass.name)")
        Text("Hero level: \(cardManager.hero.heroClass.level)")
        Text("Hero Attributes Charisma:  \(cardManager.hero.attributes.Charisma)")
        ForEach(cardManager.hero.skills) { skill in
            Text("Hero Skill: \(skill.name.capitalized)")
        }
        ForEach(cardManager.hero.items) { item in
            Text("Hero Skill: \(item.name.capitalized)")
            Text("Hero status: \(cardManager.hero.stats.health)")
        }
    }
}





#Preview {
    HeroMainView(cardManager: CardManager.shared)
}
















