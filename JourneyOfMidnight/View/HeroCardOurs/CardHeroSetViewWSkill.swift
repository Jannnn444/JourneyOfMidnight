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
//                    VStack {
//                        Text("\(hero.heroClass.name.rawValue.capitalized)")
//                            .foregroundStyle(.white)
//                            .fontDesign(.monospaced)
//                            .font(.title)
//                            .bold()
//                        
//                        ForEach(hero.skills) { skill in
//                            Text("\(skill.name): \(skill.power)")
//                                .foregroundStyle(.white)
//                                .font(.headline)
//                                .fontDesign(.monospaced)
//                        }
//                        ForEach(hero.items) { item in
//                            Text("\(item.name)")
//                                .foregroundStyle(.white)
//                                .font(.headline)
//                                .fontDesign(.monospaced)
//                        }
//                        Text("Wisdom: \(String(describing: hero.attributes.Wisdom))")
//                            .foregroundStyle(.white)
//                            .font(.headline)
//                            .fontDesign(.monospaced)
//                    }
                    
                    HeroOptionsView(hero: hero)
                    
                    // Close Button
                    Button(action: {
                        cardManager.showMoreDetail = false
                        selectedHeros = []
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

