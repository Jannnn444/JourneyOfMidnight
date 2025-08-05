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
    @Published var myHeroCards: [Hero] // Note: this for player' s card set
    @Published var enemy: [Hero]
    @Published var showMoreDetailItems: Bool = false
    @Published var showMoreDetail: Bool = false
    @Published var vendorGoods: [VendorGoods]
    @Published var gold: Gold
    @Published var stories: [Story]
    @Published var itemInMyBag: [Item]
    @Published var itemInMyBagByHero: [Item]
    @Published var navigation: Navigation = .home
    
    // MARK: 📦 Board
    let boardWidth: CGFloat = 650
    let boardHeight: CGFloat = 150
    
    // MARK: 🃏 Card
    let heroCardWidth: CGFloat = 200
    let heroCarHeight: CGFloat = 200
    
    // MARK: 🦸🏻 Hero
    let followerCardWidth: CGFloat = 100
    let followerCardHeight: CGFloat = 100
    
    // MARK: 🎲 Ability Box
    let abilityBoxWidth: CGFloat =  40
    let abilityBoxHeight: CGFloat = 40
    
    
    // NOTE: When myCardHeroCards.items.count == 2 -->>> Hero, else is Followes !
    // Hero -->>>>>>> 2 items 2 skills
    // Follower -->>> 1 items 1 skills
    private init() {
        self.myHeroCards = [
            // 1 - Follower
            Hero(
                heroClass:
                    HeroClass(name: .fighter, level: 10, life: 80),
                attributes: Attributes(
                    Strength: 10,
                    Intelligence: 101,
                    Wisdom: 10,
                    Agility: 10,
                    Vitality: 10,
                    Faith: 10,
                    Charisma: 10),
                skills: [Skill(name: "Meteor", power: 9, size: .small)]/*, Skill(name: "Dodge", power: 8)*/,
                items: [Item(name: "Armore", intro: "Love", price: 1000, size: .small)/*, Item(name: "pants", intro: "Armour")*/],
                stats: Stats(health: 100, endurance: 500),
                bag: [Item(name: "apple", intro: "Food", price: 20, size: .small)],
                heroLoad: 2,
                activeSkills: [Skill(name: "Rainy", power: 7, size: .small), Skill(name: "Meteor", power: 9, size: .small)]
            ),
            
            // 2 - Hero !!
            Hero(
                heroClass: HeroClass(name: .wizard, level: 50, life: 180),
                attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                skills: [Skill(name: "Flower", power: 8, size: .small)],
                items: [Item(name: "cat", intro: "brutal killer", price: 50, size: .large), Item(name: "holybook", intro: "Handwritten", price: 20,size: .small)],
                stats: Stats(health: 100, endurance: 500),
                bag: [Item(name: "apple", intro: "Food", price: 20, size: .small)],
                heroLoad: 4,
                activeSkills: [Skill(name: "Rainy", power: 7, size: .large), ]
            ),
            
            // 3 - Follower
            Hero(
                heroClass: HeroClass(name: .rogue, level: 50, life: 80),
                attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                skills: [Skill(name: "WolveCry", power: 5, size: .small)],
                items: [Item(name: "wands", intro: "Nature source is needed",price: 20, size: .small), /*Item(name: "Handbook", intro: "Handwritten")*/],
                stats: Stats(health: 100, endurance: 500),
                bag: [Item(name: "doggo", intro: "Sleepy pal", price: 10, size: .medium)],
                heroLoad: 2,
                activeSkills: [Skill(name: "Rainy", power: 7, size: .small), Skill(name: "WolveCry", power: 5, size: .small)]
            ),
            
            // 4 - Follower
//            Hero(
//                heroClass: HeroClass(name: .priest, level: 50, life: 80),
//                attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
//                skills: [Skill(name: "Moon", power: 8)/*, Skill(name: "WolveCry", power: 9)*/],
//                items: [/*Item(name: "wands", intro: "Nature power needed")*/ Item(name: "Handbook", intro: "Cant be exchanged", price: 5,size: .small)],
//                stats: Stats(health: 100, endurance: 500),
//                bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
//                heroLoad: 2
//            ),
        ]
        
        self.enemy = [
            // 1 - Follower
            Hero(heroClass: HeroClass(name: .wizard, level: 10, life: 80), attributes: Attributes(Strength: 6, Intelligence: 3, Wisdom: 3, Agility: 3, Vitality: 3, Faith: 3, Charisma: 3), skills: [Skill(name: "meow", power: 4, size: .small)], items: [Item(name: "cat", intro: "pet", price: 500, size: .small)/*, Item(name: "staff", intro: "weapon")*/], stats: Stats(health: 100, endurance: 500),
                 bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
                 heroLoad: 2,
                 activeSkills: [Skill(name: "Rainy", power: 7,size: .small), Skill(name: "meow", power: 4, size: .small)]
                ),
            
            // 2 - Hero !!
            Hero(heroClass: HeroClass(name: .templar, level: 11, life: 180), attributes: Attributes(Strength: 5, Intelligence: 10, Wisdom: 7, Agility: 7, Vitality: 7, Faith: 7, Charisma: 7), skills: [Skill(name: "Holy", power: 5, size: .large), Skill(name: "lightling", power: 3, size: .small)], items: [Item(name: "holybook", intro: "Spirit", price: 20, size: .small), Item(name: "cross", intro: "Belief", price: 20, size: .small)], stats: Stats(health: 100, endurance: 500),
                 bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
                 heroLoad: 4,
                 activeSkills: [Skill(name: "lightling", power: 3, size: .large)]
                ),
            
            // 3 - Follower
            Hero(heroClass: HeroClass(name: .duelist, level: 12, life: 80), attributes: Attributes(Strength: 6, Intelligence: 1, Wisdom: 9, Agility: 1, Vitality: 5, Faith: 1, Charisma: 5), skills: [Skill(name: "gun", power: 7,size: .small)/*,Skill(name: "fist", power: 6)*/], items: [Item(name: "fakeID", intro: "detect using", price: 20, size: .small)/*, Item(name: "letter", intro: "read")*/], stats: Stats(health: 100, endurance: 500),
                 bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
                 heroLoad: 2,
                 activeSkills: [Skill(name: "Rainy", power: 7,size: .small), Skill(name: "gun", power: 7,size: .small)]
                )
        ]
        
        self.vendorGoods = [VendorGoods(item: [
            Item(name: "Artifacts", intro: "Power", price: 100, size: .medium),
            Item(name: "Star", intro: "Brutal Weapon", price: 150, size: .medium),
            Item(name: "Lucky Coin",intro: "Savethrows +1", price: 100, size: .small),
            Item(name: "Goblin Journal", intro: "Lost myth", price: 250, size: .large),
            Item(name: "Potion",intro: "Not a heal \nstrength -3", price: 300, size: .small)]
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
        
        self.itemInMyBag = [Item(name: "apple", intro: "Sanity bar -10", price: 200, size: .small), Item(name: "doggo", intro: "Sleepy pal", price: 100, size: .small)]
        self.itemInMyBagByHero = [Item(name: "apple", intro: "Sanity bar -10", price: 300, size: .small)]
    }
}


    // MARK: - CardManager Extension for Attack Functions
    extension CardManager {
        
        // Calculate Attack Power
        func calculateAttackPower(for character: Hero) -> Int {
            var totalAttack = 0
            
            // Base attack from attributes (using Strength as primary)
            totalAttack += character.attributes.Strength
            
            // Add skill power (sum of all skills or highest skill)
            let skillPower = character.skills.map { $0.power }.max() ?? 0
            totalAttack += skillPower
            
            // Add item bonuses (you can expand this based on item effects)
            totalAttack += character.items.count * 2
            
            return max(1, totalAttack) // Minimum 1 damage
        }
        
        // Single hero attack function
        func heroAttack(heroIndex: Int, enemyIndex: Int) -> String {
            guard heroIndex < myHeroCards.count,
                  enemyIndex < enemy.count else {
                return "Invalid target"
            }
            
            let attackingHero = myHeroCards[heroIndex]
            let attackPower = calculateAttackPower(for: attackingHero)
            
            enemy[enemyIndex].stats.health = max(0, enemy[enemyIndex].stats.health - attackPower)
            
            let message = "\(attackingHero.heroClass.name.rawValue) attacks for \(attackPower) damage!"
            
            if enemy[enemyIndex].stats.health <= 0 {
                return message + " \(enemy[enemyIndex].heroClass.name.rawValue) defeated!"
            }
            
            return message
        }
    }
