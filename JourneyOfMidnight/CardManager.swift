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
    @Published var enemy: [Hero]
    @Published var showMoreDetailItems: Bool = false
    @Published var showMoreDetail: Bool = false
    @Published var vendorGoods: [VendorGoods]
    
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
            skills: [Skill(name: "Meteor", power: 9), Skill(name: "Dodge", power: 8)],
            items: [Item(name: "Armore", intro: "Love"), Item(name: "pants", intro: "Armour")],
            stats: Stats(health: 100, endurance: 500)),
                     Hero(
                        heroClass: HeroClass(name: .wizard, level: 50),
                        attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                        skills: [Skill(name: "Rainy", power: 7), Skill(name: "Wolve", power: 6)],
                        items: [Item(name: "wands", intro: "weapon"), Item(name: "Handbook", intro: "Handwritten")],
                        stats: Stats(health: 100, endurance: 500)),
                     Hero(
                        heroClass: HeroClass(name: .rogue, level: 50),
                        attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                        skills: [Skill(name: "Flower", power: 8), Skill(name: "WolveCry", power: 5)],
                        items: [Item(name: "wands", intro: "Nature source is needed"), Item(name: "Handbook", intro: "Handwritten")],
                        stats: Stats(health: 100, endurance: 500)),
                     Hero(
                        heroClass: HeroClass(name: .priest, level: 50),
                        attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                        skills: [Skill(name: "Moon", power: 8), Skill(name: "WolveCry", power: 9)],
                        items: [Item(name: "wands", intro: "Nature power needed"), Item(name: "Handbook", intro: "Cant be exchanged")],
                        stats: Stats(health: 100, endurance: 500))
        ]
        
        self.enemy = [
            Hero(heroClass: HeroClass(name: .wizard, level: 10), attributes: Attributes(Strength: 6, Intelligence: 3, Wisdom: 3, Agility: 3, Vitality: 3, Faith: 3, Charisma: 3), skills: [Skill(name: "meow", power: 4), Skill(name: "lightling", power: 3)], items: [Item(name: "cat", intro: "pet"), Item(name: "staff", intro: "weapon")], stats: Stats(health: 100, endurance: 500)),
            Hero(heroClass: HeroClass(name: .templar, level: 11), attributes: Attributes(Strength: 5, Intelligence: 10, Wisdom: 7, Agility: 7, Vitality: 7, Faith: 7, Charisma: 7), skills: [Skill(name: "Holy", power: 5), Skill(name: "god", power: 8)], items: [Item(name: "holybook", intro: "Spirit"), Item(name: "cross", intro: "Belief")], stats: Stats(health: 100, endurance: 500)),
            Hero(heroClass: HeroClass(name: .duelist, level: 12), attributes: Attributes(Strength: 6, Intelligence: 1, Wisdom: 9, Agility: 1, Vitality: 5, Faith: 1, Charisma: 5), skills: [Skill(name: "gunslinger", power: 7),Skill(name: "fist", power: 6)], items: [Item(name: "fakeID", intro: "detect using"), Item(name: "letter", intro: "read")], stats: Stats(health: 100, endurance: 500))
        ]
        self.vendorGoods = [VendorGoods(item: [ 
            Item(name: "Artifacts", intro: "Power"),
            Item(name: "Morningstar", intro: "Brutal Weapon"),
            Item(name: "Lucky Coin",intro: "Savethrows +1"),
            Item(name: "Goblin Journal", intro: "Lost myth"),
            Item(name: "Portion",intro: "Not a heal \nstrength -3")]
                                       )]
        
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

struct VendorGoods: Identifiable {
    var id = UUID()
    var item: [Item]
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
    var power: Int
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var intro: String
//    var price: Int
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

enum Events {
    case combat
    case vendor
    case inTheWoods
    /*
    case Game  // Banner + fight + knight
    case FortuneWheel // Banner + castle (godness blessing, king's coin rain, priest healing)
    case GroceryShop // Banner + vendor
    case Sleep // Banner + campfire
    case Forest // addditional chance to drop treasure   // Banner + forest (chest)
    */
}
                         
func shuffleEvents() -> Events {
    let allEvents: [Events] = [.combat, .inTheWoods, .vendor]
    return allEvents.randomElement() ?? .combat// Default .Game as a fallback
}
