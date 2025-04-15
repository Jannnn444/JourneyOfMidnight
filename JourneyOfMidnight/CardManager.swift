//
//  GameManager.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation

class CardManager: ObservableObject {
    // put static let shared, and makke it observable object
    static let shared = CardManager()
    
    @Published var skillName: String = ""
    @Published var skillType: SkillType = .Defense
    @Published var showAbilityDetailView: Bool = false
    @Published var hero: [Hero]
    
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
    
    private init() {
        self.hero = [Hero(
            heroClass:
                HeroClass(name: .fighter, level: 10),
                attributes: Attributes(
                    Strength: 10,
                    Intelligence: 101,
                    Wisdom: 10,
                    Agility: 10,
                    Vitality: 10,
                    Faith: 10,
                    Charisma: 10),
                skills: [Skill(name: "meteor stike"), Skill(name: "roll dodge")],
            items: [Item(name: "Armour"), Item(name: "pants")],
            stats: Stats(health: 100, endurance: 500)),
                     Hero(
                        heroClass: HeroClass(name: .wizard, level: 50),
                        attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                        skills: [Skill(name: "Magic"), Skill(name: "WolveCry")],
                        items: [Item(name: "wands"), Item(name: "Handbook")],
                        stats: Stats(health: 100, endurance: 500)),
                     Hero(
                        heroClass: HeroClass(name: .wizard, level: 50),
                        attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                        skills: [Skill(name: "Magic"), Skill(name: "WolveCry")],
                        items: [Item(name: "wands"), Item(name: "Handbook")],
                        stats: Stats(health: 100, endurance: 500)),
                     Hero(
                        heroClass: HeroClass(name: .wizard, level: 50),
                        attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                        skills: [Skill(name: "Magic"), Skill(name: "WolveCry")],
                        items: [Item(name: "wands"), Item(name: "Handbook")],
                        stats: Stats(health: 100, endurance: 500))
                     
                     ]
    }
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

// MARK: - Hero
struct Hero: Identifiable {
    var id = UUID()
    var heroClass: HeroClass
    var attributes: Attributes // now reference type
    var skills: [Skill]
    var items: [Item]
    var stats: Stats
}

struct HeroClass {
    var name: HeroClassName
    var level: Int
}

enum HeroClassName: String {
    case fighter = "Fighter"
    case wizard = "wizard"
    case rogue = "rogue"
    case priest = "priest"
    case duelist = "duelist"
    case templar = "templar"
}

struct Attributes {
    var Strength: Int = 5
    var Intelligence: Int = 5
    var Wisdom: Int = 5
    var Agility: Int = 5
    var Vitality: Int = 5
    var Faith: Int = 5
    var Charisma: Int = 5
}

struct Skill: Identifiable {
    var id = UUID()
    var name: String
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
}

struct Stats {
    var health: Int  // max health for each fight
    var endurance: Int // total health for the entire night
}

// MARK: - Occasion
struct Occasion {
    let level: Int
    let topic: String
    let description: String
    let choices: [Choice] // 3 each 1
}

struct Choice: Identifiable {
    let id = UUID() // Unique identifier t=fior the choucde
    let text: String // 'fight the dragon'
    let consequences: (inout Attributes) -> Void
    // A closure that modifies the player's attributes based on the choice
}


