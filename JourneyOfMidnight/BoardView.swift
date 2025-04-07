//
//  BoardVIew.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation
import SwiftUI

struct BoardView: View {
    @ObservedObject var cardManager = CardManager.shared
    var characterContent: [Character]?
    
    var body: some View {
        ZStack{
            // MARK: Game Board
            Rectangle()
                .frame(width: cardManager.boardWidth, height: cardManager.boardHeight)
                .foregroundColor(.lightBlue)
                .cornerRadius(20)
            // MARK: Ｗhen we use this BoardView object >>> Shows view depends on the CharacterContent
            
            /*
             BoardView(characterContent: [
             Character(name: "JanMan", type: .hero),
             Character(name: "KranMan", type: .follower)
             ]
             */
            
            HStack {
                if let characterContent = characterContent {
                    ForEach(characterContent) { character in
                        if character.type == .hero {
                            VStack{
                                HStack{
                                    ForEach(character.ability) { ability in
                                        VStack{
                                            HStack {
                                            // MARK: Display AbilityBox
                                                ForEach(0..<ability.boxAmt, id: \.self) { _ in
                                                   
                                                    // MARK: Button Hero!
                                                    Button(action: {
                                                        print("This button got pressed!")
                                                        cardManager.skillName = ability.skillName
                                                        cardManager.skillType = ability.skillType
                                                        print("Card Context: \(cardManager.skillName), \(cardManager.skillType)")
                                                        cardManager.showAbilityDetailView = true
                                                    }, label: {
                                                        AbilityBoxView(color: .yellow).padding(.trailing, 2)
                                                    })
                                                }
                                            }
                                        }
                                    }
                                }
                                HeroCardView().padding(2)
//                              Text("Hero \(character.name)")
                            }
                        } else {
                            VStack{
                                HStack{
                                    ForEach(character.ability) { ability in
                                        VStack {
                                            HStack {
                                                ForEach(0..<ability.boxAmt, id:\.self) { _ in
                                                    
                                                    // MARK: Button Follower!
                                                    Button(action: {
                                                        print("This button got pressed!")
                                                        cardManager.skillName = ability.skillName
                                                        cardManager.skillType = ability.skillType
                                                        print("Card Context: \(cardManager.skillName), \(cardManager.skillType)")
                                                        cardManager.showAbilityDetailView = true
                                                    }, label: {
                                                        AbilityBoxView(color: .blue).padding(.trailing, 2)
                                                    })
                                                }
                                            }
                                        }
                                    }
                                }
                                FollowerCardView().padding(2)
//                              Text("Follower \(character.name)")
                            }
                        }
                    }
                }
            }
            
        }
    }
}
