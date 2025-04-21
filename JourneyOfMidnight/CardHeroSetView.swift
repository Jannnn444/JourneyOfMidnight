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
    @Binding var showDetailSkillView: Bool
    @Binding var showMoreDetail: Bool
    
    var body: some View {
            HStack {
                ForEach(cardManager.hero) { hero in
                    Button(action: {
                        showDetailSkillView.toggle() // Button for shows brief skill
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
                               
                                if showDetailSkillView {
                                    // heres what we gotta do makes the view clickable
                                    VStack(alignment: .leading) {
                                        ForEach(hero.skills) { skill in
                                            // SKILLS CLICKABLE, UI -> skills title, Action -> SHOW POPUP 
                                            Button(action: {
                                                cardManager.showMoreDetail = true
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
            } .position(x: 410, y: 300)
        
          /*
           
           hero: .position(x: 410, y: 300)
           enemy: .position(x: 410, y: 150)
           
           p.s. y for the height!
           hero higher 150,
           enemy and all other events lower 300
           
           */
    }
}
