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
                    VStack {
                        Text("\(hero.heroClass.name.rawValue.capitalized)")
                            .foregroundStyle(.white)
                            .fontDesign(.monospaced)
                            .font(.title)
                            .bold()
                        
                        ForEach(hero.skills) { skill in
                            Text("\(skill.name): \(skill.power)")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .fontDesign(.monospaced)
                        }
                        ForEach(hero.items) { item in
                            Text("\(item.name)")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .fontDesign(.monospaced)
                        }
                        Text("Wisdom: \(String(describing: hero.attributes.Wisdom))")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontDesign(.monospaced)
                    }
                    
                    // Close Button
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
                }
            }
        }
    }
}
