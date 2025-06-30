//
//  CardHeroSetViewWSkill.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct CardHeroSetViewWSkill : View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedHeros: [Hero]
    @Binding var showDetailSkillView: Bool
    @Binding var showMoreDetail: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(selectedHeros) { hero in
                PopupView{
                    HeroOptionsView(hero: hero, selectedHeros: $selectedHeros)
                }
            }
        }
    }
}

