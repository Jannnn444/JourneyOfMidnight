//
//  GameManager.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation

class CardManager: ObservableObject {   //put static let shared, and makke it observable object
    static let shared = CardManager()
    
    @Published var skillName: String = ""
    @Published var skillType: SkillType = .Defense
    @Published var showNewView: Bool = false

    // MARK: 📦 Board Width/Height
    let boardWidth: CGFloat = 650
    let boardHeight: CGFloat = 150
    
    // MARK: 🃏 Card Width/Height
    let heroCardWidth: CGFloat = 160
    let heroCarHeight: CGFloat = 100
    
    // MARK: 🦸🏻 Hero Width/ Height
    let followerCardWidth: CGFloat = 100
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

struct Ability: Identifiable {
    var id = UUID()
    var skillName: String
    var boxAmt: Int
    var skillType: SkillType
}

enum SkillType: String {
    case Attack
    case Heal
    case Defense
}

