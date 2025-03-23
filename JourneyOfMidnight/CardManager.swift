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
    let boardWidth: CGFloat = 750
    let boardHeight: CGFloat = 170
    
    // MARK: 🃏 Card Width/Height
    let heroCardWidth: CGFloat = 180
    let heroCarHeight: CGFloat = 150
    
    let followerCardWidth: CGFloat = 130
    let followerCardHeight: CGFloat = 150
    private init() {}
}

struct Character: Identifiable {
    var id = UUID()
    var name: String
    var type: CharacterType
}

enum CharacterType {
    case hero
    case follower
}
