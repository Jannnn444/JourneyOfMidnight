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
                .cornerRadius(30)
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
                                            // MARK: Display skill name
                                            Text(ability.skillName)
                                                .font(.footnote)
                                                .foregroundStyle(.black)
                                            HStack {
                                            // MARK: Display AbilityBox
                                                ForEach(0..<ability.boxAmt, id: \.self) { _ in
                                                   
                                                    // MARK: Button Hero!
                                                    Button(action: {
                                                        print("This button got pressed!")
                                                        cardManager.skillName = ability.skillName
                                                        cardManager.skillType = ability.skillType
                                                        print("Card Context: \(cardManager.skillName), \(cardManager.skillType)")
                                                        cardManager.showNewView = true
                                                    }, label: {
                                                        AbilityBoxView(color: .yellow)
                                                    })
//                                                    .sheet(isPresented: $showNewView) {
//                                                        AbilityDetailViewPage(skillName: skillName, skillType: skillType)
//                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                HeroCardView()
//                              Text("Hero \(character.name)")
                            }
                        } else {
                            VStack{
                                HStack{
                                    ForEach(character.ability) { ability in
                                        VStack {
                                            Text(ability.skillName)
                                                .font(.footnote)
                                                .foregroundStyle(.black)
                                            HStack {
                                                ForEach(0..<ability.boxAmt, id:\.self) { _ in
                                                    
                                                    // MARK: Button Follower!
                                                    Button(action: {
                                                        print("This button got pressed!")
                                                        cardManager.skillName = ability.skillName
                                                        cardManager.skillType = ability.skillType
                                                        print("Card Context: \(cardManager.skillName), \(cardManager.skillType)")
                                                        cardManager.showNewView = true
                                                    }, label: {
                                                        AbilityBoxView(color: .blue)
                                                    })
//                                                    .sheet(isPresented: $showNewView) {
//                                                        AbilityDetailViewPage(skillName: skillName, skillType: skillType)
//                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                FollowerCardView().padding(.trailing)
//                              Text("Follower \(character.name)")
                            }
                        }
                    }
                }
            }
            
        }
    }
}
