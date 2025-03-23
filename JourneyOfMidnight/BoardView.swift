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
            HStack {
                HeroCardView()
                if let characterContent = characterContent {
                    ForEach(characterContent) { character in
                        if character.type == .hero {
                            Text("Hero \(character.name)")
                        } else {
                            Text("Follower \(character.name)")
                        }
                    }
                }
            }
        }
    }
}
