//
//  EnemyCardSetWSkill.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EnemyCardSetWSkill: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedEnemies: [Hero]
    @Binding var showDetailSkillViewEnemi: Bool
    @Binding var showMoreDetailEnemi: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(selectedEnemies) { enemy in
                
                PopupView{
                    VStack {
                        Text("\(enemy.heroClass.name.rawValue.capitalized)")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .bold()
                        
                        ForEach(enemy.skills) { skill in
                            Text("\(skill.name): \(skill.power)")
                                .foregroundStyle(.white)
                                .font(.headline)
                        }
                        ForEach(enemy.items) { item in
                            Text("\(item.name)")
                                .foregroundStyle(.white)
                                .font(.headline)
                        }
                        Text("Wisdom: \(String(describing: enemy.attributes.Wisdom))")
                            .foregroundStyle(.white)
                            .font(.headline)
                        
                    }.padding()
                    
                    Button(action: {
                        cardManager.showMoreDetail = false
                        selectedEnemies = []
                    }) {
                        Text("Close")
                            .padding()
                            .foregroundColor(.white)
                            .font(.headline)
                            .bold()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

