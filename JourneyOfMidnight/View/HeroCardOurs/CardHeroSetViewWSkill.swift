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
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach($selectedHeros) { hero in
                PopupView{
                    ZStack {
                        VStack {
                            HeroItemOptionsView(hero: hero) {
                                if let heroIndex = cardManager.myHeroCards.firstIndex(where: { $0.id == hero.id }) {
                                    // try to make changes async!
                                    // Update the specific hero in the array
                                    cardManager.myHeroCards[heroIndex] = hero.wrappedValue
                                }
                                cardManager.showMoreDetail = false
                                selectedHeros = []
                            }
                            
                            // Close Button
                            /*
                            Button(action: {
                                cardManager.showMoreDetail = false
                                selectedHeros = []
                            }) {
                                Text("Close")
                                    .padding(5)
                                    .foregroundColor(.black)
                                    .fontDesign(.monospaced)
                                    .bold()
                                    .font(.caption)
                                    .background(Color.gray)
                                    .cornerRadius(8)
                            }.padding(.bottom, 10)
                             */
                        }
                    }
                }
            }
        }
    }
}

