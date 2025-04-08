//
//  BoardView2.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/8.
//

import Foundation
import SwiftUI

struct BoardView2: View {
    @ObservedObject var cardManager = CardManager.shared
    var heroContent: [Hero]? //must be optional
    
    var body: some View {
        ZStack{
            // MARK: Game Board
            Rectangle()
                .frame(width: cardManager.boardWidth, height: cardManager.boardHeight)
                .foregroundColor(.lightBlue)
                .cornerRadius(20)
            
            VStack {
                if let heroContent = heroContent {
                    ForEach(heroContent) { hero in
                        // MARK: - Wizard
                        if hero.heroClass.name == .wizard {
                            ForEach(hero.skills) { skill in
                                Text("Show: \(skill)")
                            }
                        // MARK: - Priest
                        } else if hero.heroClass.name == .priest {
                           
                        // MARK: - Fighter
                        } else if hero.heroClass.name == .fighter {
                            
                        // MARK: - Duelist
                        } else if hero.heroClass.name == .duelist {
                            
                        // MARK: - Rogue
                        } else if hero.heroClass.name == .rogue {
                        
                        // MARK: - Templar
                        } else if hero.heroClass.name == .templar {
                            
                        }
                    }
                }
            }
        }
    }
}
