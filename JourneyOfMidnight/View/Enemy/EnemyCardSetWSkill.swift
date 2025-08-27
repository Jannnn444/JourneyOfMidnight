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
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach($selectedEnemies) { hero in
                PopupView{
                    HeroItemOptionsView(hero: hero) {
                        print("Looking for enemy ID: \(hero.id)")
                        print("Available enemy IDs: \(cardManager.myEnemyCards.map { $0.id })")
                        
                        if let heroIndex = cardManager.myEnemyCards.firstIndex(where: { $0.id == hero.id }) {
                            print("Found enemy at index: \(heroIndex)")
                            cardManager.myEnemyCards[heroIndex] = hero.wrappedValue
                        } else {
                            print("❌ Enemy not found in myEnemyCards!")
                        }
                        cardManager.showMoreDetail = false
                        selectedEnemies = []
                        // No need to manually update cardManager.myEnemyCards
                        // because hero is a binding that automatically syncs back
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
