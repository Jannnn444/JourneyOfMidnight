//
//  GameManager.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation

class CardManager: ObservableObject {
    // put static let shared, and make it observable object
    static let shared = CardManager()
    
    @Published var skillName: String = ""
    @Published var skillType: SkillType = .Defense
    @Published var showAbilityDetailView: Bool = false
    @Published var myHeroCards: [Hero] // Note: this for player' s card set
    @Published var myEnemyCards: [Hero]
    @Published var showMoreDetailItems: Bool = false
    @Published var showMoreDetail: Bool = false
    @Published var vendorGoods: [VendorGoods]
    @Published var gold: Gold
    @Published var stories: [Story]
    @Published var itemInMyBag: [Item]
    @Published var itemInMyBagByHero: [Item]
    @Published var navigation: Navigation = .home
    @Published var showProfile: Bool = false
    @Published var showLoginPage: Bool = false
    @Published var showSignUpView = false
    @Published var isLoggedIn: Bool = false
    @Published var staticTempIcon: String = ""
    
    // MARK: - Combat System Properties (ADD THESE)
        @Published var combatPhase: CombatPhase = .planning
        @Published var playerSkillQueue: [QueuedSkill] = []
        @Published var enemySkillQueue: [QueuedSkill] = []
        @Published var combatLog: [String] = []
        @Published var currentTurn: Int = 1
    
    enum CombatPhase {
        case planning       // Drag skills to queue
        case confirmation   // Review your choices
        case execution      // Watch skills resolve
        case resolution     // check win/lose
    }
    
    struct QueuedSkill: Identifiable {
        let id = UUID()
        let skill: Skill
        let caster: Hero
        var target: Hero?
        let initiative: Int  // Speed determines order
    }
    
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
                inventory: [
                    Item(name: "Armore", intro: "Love", price: 1000, size: .small)/*,
                    Item(name: "pants", intro: "Armour")*/],
                stats: Stats(health: 100, endurance: 500),
                bag: [Item(name: "apple", intro: "Food", price: 20, size: .small)],
                heroLoad: .follower,
                activeSkills: [Skill(name: "Rainy", power: 7, size: .small), Skill(name: "Meteor", power: 9, size: .small)]
            ),
            
            // 2 - Hero !!
            Hero(
                heroClass: HeroClass(name: .wizard, level: 50, life: 180),
                attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                skills: [Skill(name: "Flower", power: 8, size: .small)],
                inventory: [
                    Item(name: "cat", intro: "brutal killer", price: 50, size: .medium),
                    Item(name: "holybook", intro: "Handwritten", price: 20,size: .small)],          // 2 items is a hero
                stats: Stats(health: 100, endurance: 500),
                bag: [Item(name: "apple", intro: "Food", price: 20, size: .small)],
                heroLoad: .hero,
                activeSkills: [Skill(name: "Rainy", power: 7, size: .large), ]
            ),
            
            // 3 - Follower
            Hero(
                heroClass: HeroClass(name: .rogue, level: 50, life: 80),
                attributes: Attributes(Strength: 5, Intelligence: 5, Wisdom: 5, Agility: 5, Vitality: 5, Faith: 5, Charisma: 5),
                skills: [Skill(name: "WolveCry", power: 5, size: .small)],
                inventory: [Item(name: "wands", intro: "Nature source is needed",price: 20, size: .small)],
                stats: Stats(health: 100, endurance: 500),
                bag: [Item(name: "doggo", intro: "Sleepy pal", price: 10, size: .medium)],
                heroLoad: .follower,
                activeSkills: [Skill(name: "Rainy", power: 7, size: .small), Skill(name: "WolveCry", power: 5, size: .small)]
                
            ),
        ]
        
        self.myEnemyCards = [
            // 1 - Follower
            Hero(heroClass: HeroClass(name: .wizard, level: 10, life: 80),
                 attributes: Attributes(Strength: 6, Intelligence: 3, Wisdom: 3, Agility: 3, Vitality: 3, Faith: 3, Charisma: 3),
                 skills: [Skill(name: "meow", power: 4, size: .small)],
                 inventory: [Item(name: "cat", intro: "pet", price: 500, size: .small)/*, Item(name: "staff", intro: "weapon")*/],
                 stats: Stats(health: 100, endurance: 500),
                 bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
                 heroLoad: .follower,
                 activeSkills: [Skill(name: "Rainy", power: 7,size: .small), Skill(name: "meow", power: 4, size: .small)]
                
                ),
            
            // 2 - Hero !!
            Hero(heroClass:
                 HeroClass(name: .templar, level: 11, life: 180),
                 attributes: Attributes(Strength: 5, Intelligence: 10, Wisdom: 7, Agility: 7, Vitality: 7, Faith: 7, Charisma: 7),
                 skills: [Skill(name: "Holy", power: 5, size: .large),
                          Skill(name: "lightling", power: 3, size: .small)],
                 inventory: [Item(name: "holybook", intro: "Spirit", price: 20, size: .small),
                             Item(name: "cross", intro: "Belief", price: 20, size: .small)],         // 2 items is a hero
                 stats: Stats(health: 100, endurance: 500),
                 bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
                 heroLoad: .hero,
                 activeSkills: [Skill(name: "lightling", power: 3, size: .large)]
                ),
            
            // 3 - Follower
            Hero(heroClass: HeroClass(name: .duelist, level: 12, life: 80), attributes: Attributes(Strength: 6, Intelligence: 1, Wisdom: 9, Agility: 1, Vitality: 5, Faith: 1, Charisma: 5), skills: [Skill(name: "gun", power: 7,size: .small)/*,Skill(name: "fist", power: 6)*/], inventory: [Item(name: "fakeID", intro: "detect using", price: 20, size: .small)/*, Item(name: "letter", intro: "read")*/], stats: Stats(health: 100, endurance: 500),
                 bag: [Item(name: "apple", intro: "Food", price: 5, size: .small)],
                 heroLoad: .follower,
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


extension CardManager {
    // MARK: - 1. Initiative System (Speed-Based Turn Order)
    func calculateInitiative(for hero: Hero) -> Int {
        let baseSpeed = hero.attributes.Agility
        let randomFactor = Int.random(in: 1...6) // D6 roll
        return baseSpeed + randomFactor
    }
    
    // MARK: - 2. Get Size Multiplier (MOVED BEFORE executeSkill)
    func getSizeMultiplier(_ size: itemSizes) -> Double {
        switch size {
        case .small: return 1.0
        case .medium: return 1.5
        case .large: return 2.5
        }
    }
    
    // MARK: - 3. Skill Execution with Effects
    func executeSkill(queued: QueuedSkill) -> CombatResult {
        guard var target = queued.target else {
            return CombatResult(message: "No target selected", damage: 0)
        }
        
        let skill = queued.skill
        let caster = queued.caster
        
        // Calculate damage based on skill power + attributes
        var damage = skill.power
        
        // Add attribute modifiers (since you don't have SkillType, use skill power only)
        // You can add Intelligence/Strength bonus based on hero class instead
        switch caster.heroClass.name {
        case .wizard, .priest, .templar:
            damage += caster.attributes.Intelligence / 2  // Magic users
        case .fighter, .duelist:
            damage += caster.attributes.Strength / 2      // Physical fighters
        case .rogue:
            damage += caster.attributes.Agility / 2       // Agile attackers
        }
        
        // Apply skill size multiplier
        let sizeMultiplier = getSizeMultiplier(skill.size)
        damage = Int(Double(damage) * sizeMultiplier)
        
        // Apply damage
        if damage > 0 {
            target.stats.health = max(0, target.stats.health - damage)
            let defeated = target.stats.health <= 0
            let message = "\(caster.heroClass.name.rawValue) uses \(skill.name)! \(target.heroClass.name.rawValue) takes \(damage) damage!"
            
            return CombatResult(
                message: message,
                damage: damage,
                targetDefeated: defeated
            )
        }
        
        // Default: skill used but no damage
        return CombatResult(
            message: "\(caster.heroClass.name.rawValue) uses \(skill.name)!",
            damage: 0,
            targetDefeated: false
        )
    }
    
    // MARK: - 4. Full Turn Resolution
    func resolveCombatTurn() {
        combatPhase = .execution
        combatLog.removeAll()
        
        // Combine all queued skills
        var allActions = playerSkillQueue + enemySkillQueue
        
        // Sort by initiative (highest goes first)
        allActions.sort { $0.initiative > $1.initiative }
        
        // Execute each skill in order
        for action in allActions {
            let result = executeSkill(queued: action)
            combatLog.append(result.message)
            
            // Check if combat should end
            if checkVictoryCondition() {
                combatPhase = .resolution
                return
            }
        }
        
        // Clear queues for next turn
        playerSkillQueue.removeAll()
        enemySkillQueue.removeAll()
        currentTurn += 1
        combatPhase = .planning
    }
    
    // MARK: - 5. Victory/Defeat Checking
    func checkVictoryCondition() -> Bool {
        let heroesAlive = myHeroCards.filter { $0.stats.health > 0 }
        let enemiesAlive = myEnemyCards.filter { $0.stats.health > 0 }
        
        if enemiesAlive.isEmpty {
            combatLog.append("🎉 Victory! All enemies defeated!")
            return true
        }
        
        if heroesAlive.isEmpty {
            combatLog.append("💀 Defeat! All heroes have fallen!")
            return true
        }
        
        return false
    }
    
    // MARK: - 6. AI Enemy Turn (Simple)
    func executeEnemyTurn() {
        // Simple AI: Each enemy picks random skill and targets random hero
        for enemy in myEnemyCards where enemy.stats.health > 0 {
            guard let randomSkill = enemy.activeSkills.randomElement(),
                  let randomTarget = myHeroCards.filter({ $0.stats.health > 0 }).randomElement() else {
                continue
            }
            
            let initiative = calculateInitiative(for: enemy)
            let queuedSkill = QueuedSkill(
                skill: randomSkill as! Skill,
                caster: enemy,
                target: randomTarget,
                initiative: initiative
            )
            
            enemySkillQueue.append(queuedSkill)
        }
    }
}

// MARK: - Combat Result Model (WITH CUSTOM INITIALIZER)
struct CombatResult {
    let message: String
    let damage: Int
    let targetDefeated: Bool
    
    // Custom initializer with default value for targetDefeated
    init(message: String, damage: Int, targetDefeated: Bool = false) {
        self.message = message
        self.damage = damage
        self.targetDefeated = targetDefeated
    }
}
