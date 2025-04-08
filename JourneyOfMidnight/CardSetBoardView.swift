//
//  CardBoardView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/7.
//

import Foundation
import SwiftUI

struct CardSetBoardView: View {
    @ObservedObject var cardManager = CardManager.shared
    var heroContent: [Hero]?
    
    var body: some View {
        ZStack{
            // MARK: Game Board
            Rectangle()
                .frame(width: cardManager.boardWidth, height: cardManager.boardHeight)
                .foregroundColor(.lightBlue)
                .cornerRadius(20)
            
            HStack {
                if let heroContent = heroContent {
                    ForEach(heroContent) { hero in
                        VStack{
                            
                            Text("Class: \(hero.heroClass.name.rawValue)")
                            Text("Level: \(hero.heroClass.level)")
                            Text("Charisma: \(hero.attributes.Charisma)")
                            Text("Faith:\(hero.attributes.Faith)")
                            
                            ForEach(hero.skills) { skill in
                                Text("Skill: \(skill.name)")
                            }
                            ForEach(hero.items) { item in
                                
                                Text("Item: \(item.name)")
                            }
                            
                            
                            HStack {
                            ForEach(hero.skills) { skill in
                                    // MARK: Display AbilityBox
                                    Button(action: {
                                        print("This button got pressed!")
                                        cardManager.skillName = skill.name
                                        cardManager.showAbilityDetailView = true
                                    }, label: {
                                        VStack {
                                            AbilityBoxView(color: .yellow).padding(.trailing, 2)
                                        }
                                    })
                                }
                                
                                
                            }
                            HeroCardView().padding(2)
                        }
                        
                    }
                }
            }
        }
        
    }
}
#Preview {
    CardSetBoardView(cardManager: CardManager.shared, heroContent: tempPlayerCardSet1)
}
