//
//  Game.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import Foundation

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
    var bag: [Item] //new!
    var heroLoad: Int
    var activeSkills : [Skill]
    var isChose: Bool
}


struct Follower: Identifiable {
    var id = UUID()
    var heroClass: HeroClass
    var attributes: Attributes
    var skills: [Skill]
    var items: [Item]
    var stas: Stats
}

struct HeroClass {
    var name: HeroClassName
    var level: Int
    var life: Int
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
    var size: itemSizes
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var intro: String
    var price: Int
    var size: itemSizes
    var isChose: Bool
}

enum itemSizes: Int {
    case small = 1
    case medium = 2
    case large = 4
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

// NOTE: 20250702

/*
 Wheres that pink bubble we need ?
 All around the world be loved be cared be remembered
 maybe we should celebrate on the day or just go on weekend ?
 No ideas and Crazy sense of knowing some ideas are bothering me a lot
 Cruel or not is that they have no sensation or any ability to love and be pathetic
 */
