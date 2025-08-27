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
//    @Binding var showDetailSkillViewEnemi: Bool
//    @Binding var showMoreDetailEnemi: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach($selectedEnemies) { hero in
                PopupView{
                    HeroItemOptionsView(hero: hero) {
                        cardManager.showMoreDetail = false
                        selectedEnemies = []
                    }
                    
                    // Close Button
                    /*
                    Button(action: {
                        cardManager.showMoreDetail = false
                        selectedEnemies = []
                    }) {
                        Text("Close")
                            .padding()
                            .foregroundColor(.black)
                            .fontDesign(.monospaced)
                            .bold()
                            .font(.headline)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                     */
                }
            }
        }
    }
}
