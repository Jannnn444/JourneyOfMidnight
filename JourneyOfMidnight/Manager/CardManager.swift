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
    @Published var gold: Gold
    @Published var stories: [Story]
    
    @Published var playerInQueueForTesting: [FindMatchPayload]
    
    @Published var navigation: Navigation = .home
    
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
            Item(name: "Morning Star", intro: "Brutal Weapon"),
            Item(name: "Lucky Coin",intro: "Savethrows +1"),
            Item(name: "Goblin Journal", intro: "Lost myth"),
            Item(name: "Potion",intro: "Not a heal \nstrength -3")]
                                       )]
        self.gold = Gold(gold: 10000)
        
        self.stories = [
            Story(topic: "Waken from an abandoned chapel, you found a body cruelly harmed and passed right next to you. You smell the blood on your hand. ", choice: [Option(option: "Admit your crime", effect: 5, effectType: .Charisma), Option(option: "Wash your hands", effect: 5, effectType: .Wisdom), Option(option: "go back to sleep", effect: 5, effectType: .Agility)]),
            Story(topic: "Unusual mist start gathering in front of you, you sence the creep atmosphere, you turn back, but all you see just white wall...", choice: [Option(option: "Shout all the saint chris name, hope any evils step back and scared", effect: 7, effectType: .Faith), Option(option: "(Sorceror)Natural force to find a path", effect: 4, effectType: .Intelligence), Option(option: "(Dexterity)Listen to where the river shivering", effect: 5, effectType: .Vitality)]),
            Story(topic: "You heard a wild animals roaring, but you not in the mood for wild friend now, what will you do?", choice: [Option(option: "(Inspection)Take a closer look of what happened", effect: 5, effectType: .Agility),Option(option: "(Rogue)A friend in need is a friend in need", effect: 5, effectType: .Vitality),Option(option: "You really in a rush and having a bad day. Leave it", effect: 3, effectType: .Wisdom)]),
            Story(topic: "In this big and further forest, u so hungry...", choice: [
                Option(option: "Go village and look for food", effect: 6, effectType: .Faith), Option(option: "Rather eat yourself to stay loyal to the vow you have compromised the lord", effect: 3, effectType: .Vitality), Option(option: "Take this hunger to be better", effect: 3, effectType: .Charisma)
            ])
        ]
        
        self.playerInQueueForTesting = []
    }
}

// model
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
    var attributes: Attributes
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
    //  var price: Int   // Future TBD
}

struct Stats {
    var health: Int  // max health for each fight
    var endurance: Int // total health for the entire night
}

enum Events {
    case combat
    case vendor
    case inTheWoods
}

func shuffleEvents() -> Events {
    let allEvents: [Events] = [.combat, .inTheWoods, .vendor]
    return allEvents.randomElement() ?? .combat
}

struct Gold {
    let gold: Int
}

struct Story: Identifiable {
    var id = UUID()
    var topic: String
    var choice: [Option]
}

struct Option: Identifiable {
    var id = UUID()
    var option: String
    var effect: Int
    var effectType: EffectTypes
}

enum EffectTypes {
    case Strength
    case Intelligence
    case Wisdom
    case Agility
    case Vitality
    case Faith
    case Charisma
}
