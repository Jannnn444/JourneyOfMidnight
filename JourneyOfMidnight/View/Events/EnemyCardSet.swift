//
//  EnemyCardSet.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EnemyCardSet: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedEnemies: [Hero]
    @Binding var showDetailSkillViewEnemi: Bool
    @Binding var showMoreDetailEnemi: Bool
    
    var body: some View {
        HStack {
            ForEach(cardManager.enemy) { enemy in
                Button(action: {
                    showDetailSkillViewEnemi.toggle() // Button for shows brief skill
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 130)
                            .foregroundColor(.brown)
                            .cornerRadius(10)
                            .offset(x: 5)
                            .offset(y: 8)
                        Rectangle()
                            .frame(width: 100, height: 130)
                            .foregroundColor(.yellow)
                            .cornerRadius(10)
                        
                        VStack() {
                            var myHero = enemy.heroClass.name
                            if myHero == HeroClassName.fighter {
                                Image("knight")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == HeroClassName.wizard {
                                Image("princess")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == HeroClassName.priest {
                                Image("priest")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == HeroClassName.duelist {
                                Image("duelist")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == HeroClassName.rogue {
                                Image("rogue")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == HeroClassName.templar {
                                Image("templar")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                            
                            Text(enemy.heroClass.name.rawValue.capitalized)
                                .font(.headline)
                                .fontDesign(.monospaced)
                                .bold()
                            
                            if showDetailSkillViewEnemi {
                                // heres what we gotta do
                                // makes the view clickable
                                VStack(alignment: .leading) {
                                    ForEach(enemy.skills) { skill in
                                        // Have the skills able to be buttons and expand to show more infos
                                        Button(action: {
                                            cardManager.showMoreDetail = true
                                            selectedEnemies.append(enemy)
                                        }) {
                                            DetailSkillView(skill: skill)
                                        }
                                    }
                                }
                            }
                        }
                    } // Zstack
                }
            } // ForEach hero
        } .position(x: 450, y: 150)  // y: for the height!
    }
}

