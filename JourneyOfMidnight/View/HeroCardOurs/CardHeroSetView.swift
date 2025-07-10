//
//  CardHeroSetView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct CardHeroSetView: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var IsShowDetailSkillView: Bool
    @Binding var showMoreDetail: Bool
    @Binding var selectedHeros: [Hero]
 
    var body: some View {
        HStack {
            ForEach(cardManager.myHeroCards) { hero in
                Button(action: {
                    IsShowDetailSkillView.toggle() // Button for shows brief skill
                }) {
                    VStack { // Vstack above cards
                     
                        HStack {
                            ForEach(hero.skills) { skill in
                                ZStack {
                                    Rectangle()
                                        .frame(width: cardManager.abilityBoxWidth, height: cardManager.abilityBoxHeight)
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
                            ForEach(hero.items) { item in
                                ZStack {
                                    Rectangle()
                                        .frame(width: cardManager.abilityBoxWidth, height: cardManager.abilityBoxHeight)
                                        .foregroundStyle(.white)
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.green, lineWidth: 2)
                                        )
                                    
                                    Image("\(item.name)")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .frame(
                                    width: hero.items.count == 2 ? 200 : 100,
                                    height: 130)
                                .foregroundColor(.brown)
                                .cornerRadius(10)
                                .offset(x: 5)
                                .offset(y: 8)
                            Rectangle()
                                .frame(
                                    width: hero.items.count == 2 ? 200 : 100,
                                    height: 130)
                                .foregroundColor(.yellow)
                                .cornerRadius(10)
                            
                            VStack() {
                                // MARK : - Life Bar
                                Rectangle()
                                    .frame(width: CGFloat(hero.heroClass.life), height: 3)
                                    .foregroundColor(.red)
                                    .cornerRadius(12)
                                
                                // MARK : - Yellow card
                                var myHero = hero.heroClass.name
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
                                    Image("king")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                } else if myHero == HeroClassName.templar {
                                    Image("templar")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                                
//                                Text("\(hero.heroClass.life)")
//                                    .font(.headline)
//                                    .fontDesign(.monospaced)
//                                    .bold()
                                
                                Text(hero.heroClass.name.rawValue.capitalized)
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .bold()
                                
                                if IsShowDetailSkillView {
                                    // if showDetailView shows
                                    // heres what we gotta do makes the view clickable and will click popup new more detail view
                                   HStack() {
                                        ForEach(hero.skills) { skill in
                                            // SKILLS CLICKABLE, UI -> skills title, Action -> SHOW POPUP
                                            Button(action: {
                                                cardManager.showMoreDetail = true
                                                selectedHeros.append(hero)
                                            }) {
                                                DetailSkillView(skill: skill)
                                            }
                                        }
                                    }
                                }
                            }
                        } // Zstack
                    } // Vstack above the Hero Cards
                }
            } // ForEach hero
        } .position(x: 430, y: 310)

          /*
           
           hero: .position(x: 410, y: 300)
           enemy: .position(x: 410, y: 150)
           
           p.s. y for the height!
           hero higher 150,
           enemy and all other events lower 300
           
           */
    }
}
