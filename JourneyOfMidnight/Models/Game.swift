//
//  Game.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//import Foundation// MARK: - Character/// Represents a character in the game, which can be a hero or a follower.
struct Character: Identifiable {
    let id = UUID()
    var name: String
    var type: CharacterType
    var abilities: [Ability]
}enum CharacterType {
    case hero
    case follower
}/// Represents an ability that a character can have.
struct Ability: Identifiable {
    let id = UUID()
    var skillName: String
    var boxAmt: Int // TODO: Clarify what 'boxAmt' means; consider renaming for clarity
    var skillType: SkillType
}enum SkillType: String, Codable {
    case attack = "Attack"
    case heal = "Heal"
    case defense = "Defense"
}// MARK: - Hero and Follower/// Represents the hero in the game.
struct Hero: Identifiable, Codable {
    let id = UUID()
    var heroClass: HeroClass
    var attributes: Attributes
    var skills: [Skill]
    var items: [Item] // Equipped items
    var stats: Stats
    var bag: [Item] // Inventory
    var heroLoad: Int // Possibly carrying capacity or load/// Calculates the maximum health based on vitality.
var maxHealth: Int {
    stats.health + attributes.vitality * 10 // Example calculation
}

/// Adds an item to the bag if there's space.
mutating func addItemToBag(_ item: Item) -> Bool {
    let currentLoad = bag.reduce(0) { $0 + $1.size.rawValue } + heroLoad
    if currentLoad + item.size.rawValue <= maxLoad {
        bag.append(item)
        return true
    }
    return false
}

/// Maximum load the hero can carry.
var maxLoad: Int {
    attributes.strength * 5 // Example
}}/// Represents a follower in the game.
struct Follower: Identifiable, Codable {
    let id = UUID()
    var heroClass: HeroClass
    var attributes: Attributes
    var skills: [Skill]
    var items: [Item]
    var stats: Stats // Fixed typo from 'stas' to 'stats'// Added bag and heroLoad for consistency with Hero
var bag: [Item] = []
var heroLoad: Int = 0

/// Calculates the maximum health based on vitality.
var maxHealth: Int {
    stats.health + attributes.vitality * 5 // Slightly less than hero
}}// MARK: - Hero Class/// Defines the class of a hero or follower.
struct HeroClass: Codable {
    var name: HeroClassName
    var level: Int
    var life: Int // Possibly lives or max endurance
}enum HeroClassName: String, Codable {
    case fighter = "Fighter"
    case wizard = "Wizard" // Capitalized for consistency
    case rogue = "Rogue"
    case priest = "Priest"
    case duelist = "Duelist"
    case templar = "Templar"
}// MARK: - Vendor/// Goods available from a vendor.
struct VendorGoods: Identifiable {
    let id = UUID()
    var items: [Item]
}// MARK: - Attributes, Skills, Items, Stats/// Attributes that define a character's capabilities.
struct Attributes: Codable {
    var strength: Int = 5
    var intelligence: Int = 5
    var wisdom: Int = 5
    var agility: Int = 5
    var vitality: Int = 5
    var faith: Int = 5
    var charisma: Int = 5/// Total attribute points.
var total: Int {
    strength + intelligence + wisdom + agility + vitality + faith + charisma
}

/// Mutates an attribute by a given amount.
mutating func modify(_ type: EffectTypes, by amount: Int) {
    switch type {
    case .strength: strength += amount
    case .intelligence: intelligence += amount
    case .wisdom: wisdom += amount
    case .agility: agility += amount
    case .vitality: vitality += amount
    case .faith: faith += amount
    case .charisma: charisma += amount
    }
}}/// A skill that a character can use.
struct Skill: Identifiable, Codable {
    let id = UUID()
    var name: String
    var power: Int
    // var size: itemSizes // Commented out; unclear purpose
}/// An item in the game.
struct Item: Identifiable, Codable {
    let id = UUID()
    var name: String
    var intro: String // Description
    var price: Int
    var size: ItemSize// Added for more depth
var weight: Int {
    size.rawValue * 2 // Example
}}enum ItemSize: Int, Codable {
    case small = 1
    case medium = 2
    case large = 3
}/// Stats for health and endurance.
struct Stats: Codable {
    var health: Int  // Max health for each fight
    var endurance: Int // Total health for the entire night
}// MARK: - Eventsenum EventType {
    case combat
    case vendor
    case inTheWoods
}/// Shuffles and returns a random event.
func generateRandomEvent() -> EventType {
    let allEvents: [EventType] = [.combat, .inTheWoods, .vendor]
    return allEvents.randomElement() ?? .combat
}// MARK: - Gold, Story, Option/// Represents gold currency.
struct Gold {
    let amount: Int // Renamed from 'gold' for clarity
}/// A story segment with choices.
struct Story: Identifiable {
    let id = UUID()
    var topic: String
    var choices: [Option] // Renamed from 'choice' for plural consistency
}/// An option in a story.
struct Option: Identifiable {
    let id = UUID()
    var text: String // Renamed from 'option' for clarity
    var effect: Int
    var effectType: EffectTypes
}enum EffectTypes {
    case strength
    case intelligence
    case wisdom
    case agility
    case vitality
    case faith
    case charisma
}// NOTE: 20250702/*
 Wheres that pink bubble we need ?
 All around the world be loved be cared be remembered
 maybe we should celebrate on the day or just go on weekend ?
 No ideas and Crazy sense of knowing some ideas are bothering me a lot
 Cruel or not is that they have no sensation or any ability to love and be pathetic
 */

