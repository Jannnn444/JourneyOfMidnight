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
                                HeroCardView()
                                Text("Hero \(character.name)")
                            }
                        } else {
                            VStack{
                                FollowerCardView()
                                Text("Follower \(character.name)")
                            }
                        }
                    }
                }
            }
        }
    }
}
