//
//  GameManager.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation

class CardManager: ObservableObject {   //put static let shared, and makke it observable object
    static let shared = CardManager()
    
    // MARK: 📦 Board Width/Height
    let boardWidth: CGFloat = 500
    let boardHeight: CGFloat = 130
    
    // MARK: 🃏 Card Width/Height
    let heroCardWidth: CGFloat = 120
    let heroCarHeight: CGFloat = 100
    
    // MARK: 🦸🏻 Hero Width/ Height
    let followerCardWidth: CGFloat = 80
    let followerCardHeight: CGFloat = 100
    
    // MARK: 🎲 Ability Box Width/Height
    let abilityBoxWidth: CGFloat =  20
    let abilityBoxHeight: CGFloat = 15
    
    private init() {} 
}

// MARK: Build Character
struct Character: Identifiable {
    var id = UUID()
    var name: String
    var type: CharacterType
    var ability: [Ability]
}

enum CharacterType {
    case hero
    case follower
}

// MARK: Build Ability
struct Ability: Identifiable {
    var id = UUID()
    var skillName: String
    var type: CharacterType
}
