//
//  EnemyCardSetWSkill.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import SwiftUI

struct EnemyCardSetWSkill: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedEnemies: [Hero]
    @Binding var showDetailSkillViewEnemi: Bool
    @Binding var showMoreDetailEnemi: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(selectedEnemies) { hero in
                PopupView{
                    HeroOptionsView(hero: hero, selectedHeros: $selectedEnemies)
                }
            }
        }
    }
}
