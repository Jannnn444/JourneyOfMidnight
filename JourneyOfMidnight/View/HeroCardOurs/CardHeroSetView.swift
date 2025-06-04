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
            ForEach(cardManager.hero) { hero in
                Button(action: {
                    IsShowDetailSkillView.toggle() // Button for shows brief skill
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
                            
                            Text(hero.heroClass.name.rawValue.capitalized)
                                .font(.headline)
                                .fontDesign(.monospaced)
                                .bold()
                            
                            if IsShowDetailSkillView {
                                // if showDetailView shows
                                // heres what we gotta do makes the view clickable and will click popup new more detail view
                                VStack(alignment: .leading) {
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
                }
            } // ForEach hero
        } .position(x: 430, y: 330)

          /*
           
           hero: .position(x: 410, y: 300)
           enemy: .position(x: 410, y: 150)
           
           p.s. y for the height!
           hero higher 150,
           enemy and all other events lower 300
           
           */
    }
}
