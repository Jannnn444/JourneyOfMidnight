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
                    VStack {
                        HStack {
                            ForEach(enemy.activeSkills) { skill in
                            ZStack {
                                Rectangle()
                                    .frame(width: CGFloat(skill.size.rawValue) * cardManager.abilityBoxWidth, height: cardManager.abilityBoxHeight)
                                    .foregroundStyle(.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.red, lineWidth: 2)
                                    )
                                
                                Image("\(skill.name)")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                              }
                            }
//                            ForEach(enemy.items) { item in
//                                ZStack {
//                                    Rectangle()
//                                        .frame(width: cardManager.abilityBoxWidth, height: cardManager.abilityBoxHeight)
//                                        .foregroundStyle(.white)
//                                        .cornerRadius(12)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color.green, lineWidth: 2)
//                                        )
//                                    
//                                    Image("\(item.name)")
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                }
//                            }
                        }
                        ZStack {
                            Rectangle()
                                .frame(
                                    width: enemy.heroLoad == 4 ? 200 : 100,
                                    height: 130)
                                .foregroundColor(.gray)
                                .cornerRadius(10)
                                .offset(x: 5)
                                .offset(y: 8)
                            Rectangle()
                                .frame(
                                    width: enemy.heroLoad == 4 ? 200 : 100,
                                    height: 130)
                                .foregroundColor(.orange)
                                .cornerRadius(10)
                            
                            VStack() {
                                
                                // MARK : - Life Bar
                                Rectangle()
                                    .frame(width: CGFloat(enemy.heroClass.life), height: 3)
                                    .foregroundColor(.red)
                                    .cornerRadius(12)
                                
                                // MARK : - Yellow card
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
                                
                                // Zstack this! on blood bar
//                                Text("\(enemy.heroClass.life)")
//                                    .font(.headline)
//                                    .fontDesign(.monospaced)
//                                    .bold()
                                
                                Text(enemy.heroClass.name.rawValue.capitalized)
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .bold()
                                
                                if showDetailSkillViewEnemi {
                                    // heres what we gotta do
                                    // makes the view clickable
                                    HStack() {
                                        ForEach(enemy.skills) { skill in
                                            // Have the skills able to be buttons and expand to show more popup infos
                                            Button(action: {
                                                cardManager.showMoreDetail = true // popip
                                                selectedEnemies.append(enemy)
                                            }) {
                                                DetailSkillView(skill: skill)
                                            }
                                        }
                                    }
                                }
                            }
                        } // Zstack
                    } // Vstack aboved the Cards
                }
            } // ForEach hero
        } .position(x: 430, y: 130)  // y: for the height!
    }
}

