//
//  EventScreenTemplate.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/5/1.
//

import SwiftUI

// A concrete implementation of a template for event screens without generics
struct EventScreenTemplate: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var eventState: Events
    @Binding var gold: Gold
    @AppStorage("selectedAppColor") private var selectedColorName = "black"
    
    // Event-specific content
    let eventContent: AnyView
    // Event-specific popup content
    let eventPopupContent: AnyView?
    
    // Common state for all event types
    @State private var selectedHeros: [Hero] = []
    @State private var showDetailSkillViewHero: Bool = false
    @State private var showMoreDetailHero: Bool = false
    @State private var showBagView = false
    
    // Battle state
    @State private var isBattleInProgress = false
    @State private var battleLog: [String] = []
    @State private var showBattleLog = false
    @State private var showFightingAnimation = false
    
    // Combat-specific bindings
    private var selectedEnemies: Binding<[Hero]>?
    private var showDetailSkillViewEnemi: Binding<Bool>?
    private var showMoreDetailEnemi: Binding<Bool>?
    
    // For combat events
    init(
        eventState: Binding<Events>,
        gold: Binding<Gold>,
        selectedEnemies: Binding<[Hero]>,
        showDetailSkillViewEnemi: Binding<Bool>,
        showMoreDetailEnemi: Binding<Bool>
    ) {
        self._eventState = eventState
        self._gold = gold
        self.selectedEnemies = selectedEnemies
        self.showDetailSkillViewEnemi = showDetailSkillViewEnemi
        self.showMoreDetailEnemi = showMoreDetailEnemi
        
        // Create the combat event content
        self.eventContent = AnyView(
            ZStack {
                EventCombat()
                
//                EnemyCardSet(
//                    selectedEnemies: selectedEnemies,
//                    showDetailSkillViewEnemi: showDetailSkillViewEnemi,
//                    showMoreDetailEnemi: showMoreDetailEnemi
//                )
            }
        )
        
        // Create event popup content
        self.eventPopupContent = AnyView(
            EnemyCardSetWSkill(
                selectedEnemies: selectedEnemies
            )
        )
    }
    
    // For vendor events
    init(
        eventState: Binding<Events>,
        gold: Binding<Gold>,
        selectedItem: Binding<Item?>,
        showDetailItemView: Binding<Bool>,
        showMoreDetailItems: Binding<Bool>
    ) {
        self._eventState = eventState
        self._gold = gold
        self.selectedEnemies = nil
        self.showDetailSkillViewEnemi = nil
        self.showMoreDetailEnemi = nil
        
        // Create the vendor event content
        self.eventContent = AnyView(
            EventVendorShop(
                IsShowDetailItemView: showDetailItemView,
                showMoreDetail: showDetailItemView,
                selectedItem: selectedItem
            )
        )
        
        // Create event popup content
        self.eventPopupContent = AnyView(
            EventVendorPopup(
                selectedItem: selectedItem,
                showDetailSkillView: showDetailItemView,
                showMoreDetailItems: showMoreDetailItems
            )
        )
    }
    
    // For forest events
    init(
        eventState: Binding<Events>,
        gold: Binding<Gold>,
        stories: Binding<[Story]>
    ) {
        self._eventState = eventState
        self._gold = gold
        self.selectedEnemies = nil
        self.showDetailSkillViewEnemi = nil
        self.showMoreDetailEnemi = nil
        
        // Create the forest event content
        self.eventContent = AnyView(
            EventForest(stories: stories)
        )
        
        // No event-specific popup needed for forest events
        self.eventPopupContent = nil
    }
    
    var body: some View {
        ZStack {
            // Background
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            // The event-specific content
//            eventContent
            
            // Enemies
            CardHeroSetView(
                IsShowDetailSkillView: $showDetailSkillViewHero,
                showMoreDetail: $showMoreDetailHero,
                selectedHeros: $selectedHeros,
                hero: false
            )
            
            // Heros
            CardHeroSetView(
                IsShowDetailSkillView: $showDetailSkillViewHero,
                showMoreDetail: $showMoreDetailHero,
                selectedHeros: $selectedHeros
            )
            
            // Hero skills popup
            CardHeroSetViewWSkill(
                selectedHeros: $selectedHeros
               
            )
            
            // Event-specific popup content if available
            if let popup = eventPopupContent {
                popup
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    
                    // Battle log button (only show in combat)
                    if eventState == .combat {
                        Button(action: {
                            showBattleLog.toggle()
                        }) {
                            Image(systemName: "doc.text")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding(.leading)
                    }
                    
                    // button bag at top-right
                    Button(action: {
                        showBagView.toggle()
                    }) {
                        Image("bag")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.leading)
                    
                    
                }
                Spacer()
            }
            .padding()
            .padding(.top, 10)
            .padding(.trailing, 110)
            
            // bottom UI elements
            VStack {
                Spacer() // push to the buttom
                HStack {
                    Spacer()  // push to right
                    
                    VStack {
                        // Only show attack button in combat mode
                        if eventState == .combat {
                            Button(action: {
                                performBattleAction()
                            }) {
                                Text(isBattleInProgress ? "Auto Battle" : "Attack")
                                    .padding()
                                    .fontDesign(.monospaced)
                                    .background(Color.fromHex(selectedColorName).opacity(0.6))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(isBattleInProgress)
                        }
                        
                        ButtomButton(eventState: $eventState, textOnButton: "Next Day")
                    }
                }
            }
            .padding(.bottom, 60)
            .padding()
                
            // Gold display
            GoldView(gold: $gold)
                .padding()
            
            // Bag popup
            if showBagView {
                PopupView(content: {
                    BagView(gold: gold, itemInMyBag: cardManager.itemInMyBag, selectedHeroBag: cardManager.itemInMyBagByHero, isPresented: $showBagView, showIntroView: false)
                })
            }
            
            // Battle log popup
            if showBattleLog {
                PopupView(content: {
                    BattleLogView(battleLog: battleLog, onClose: {
                        showBattleLog = false
                    })
                })
            }
            
            // Fighting animation popup
            if showFightingAnimation {
                FightingAnimationView()
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Battle Functions
    
    private func performBattleAction() {
        guard eventState == .combat else { return }
        
        isBattleInProgress = true
        showFightingAnimation = true
        battleLog = []
        
        // Add battle start message
        battleLog.append("🗡️ Battle begins!")
        
        // Perform the battle with animation delays
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.executeBattleSequence()
        }
    }
    
    private func executeBattleSequence() {
        var battleRound = 1
        let maxRounds = 10 // Prevent infinite loops
        
        func executeRound() {
            guard battleRound <= maxRounds,
                  cardManager.myHeroCards.contains(where: { $0.stats.health > 0 }),
                  cardManager.myEnemyCards.contains(where: { $0.stats.health > 0 }) else {
                // Battle ended
                finalizeBattle()
                return
            }
            
            battleLog.append("\n--- Round \(battleRound) ---")
            
            // Heroes attack
            for (heroIndex, hero) in cardManager.myHeroCards.enumerated() {
                guard hero.stats.health > 0 else { continue }
                
                if let enemyIndex = cardManager.myEnemyCards.firstIndex(where: { $0.stats.health > 0 }) {
                    let damage = cardManager.calculateAttackPower(for: hero)
                    cardManager.myEnemyCards[enemyIndex].stats.health = max(0, cardManager.myEnemyCards[enemyIndex].stats.health - damage)
                    
                    battleLog.append("\(hero.heroClass.name.rawValue) attacks \(cardManager.myEnemyCards[enemyIndex].heroClass.name.rawValue) for \(damage) damage!")
                    
                    if cardManager.myEnemyCards[enemyIndex].stats.health <= 0 {
                        battleLog.append("\(cardManager.myEnemyCards[enemyIndex].heroClass.name.rawValue) has been defeated!")
                        handleEnemyDefeat(enemyIndex: enemyIndex)
                    }
                }
            }
            
            // Check if all enemies defeated
            if cardManager.myEnemyCards.allSatisfy({ $0.stats.health <= 0 }) {
                battleLog.append("\n🎉 Victory! All enemies defeated!")
                finalizeBattle()
                return
            }
            
            // Enemies counter-attack
            for (enemyIndex, enemy) in cardManager.myEnemyCards.enumerated() {
                guard enemy.stats.health > 0 else { continue }
                
                if let heroIndex = cardManager.myHeroCards.firstIndex(where: { $0.stats.health > 0 }) {
                    let damage = cardManager.calculateAttackPower(for: enemy)
                    cardManager.myHeroCards[heroIndex].stats.health = max(0, cardManager.myHeroCards[heroIndex].stats.health - damage)
                    
                    battleLog.append("\(enemy.heroClass.name.rawValue) attacks \(cardManager.myHeroCards[heroIndex].heroClass.name.rawValue) for \(damage) damage!")
                    
                    if cardManager.myHeroCards[heroIndex].stats.health <= 0 {
                        battleLog.append("\(cardManager.myHeroCards[heroIndex].heroClass.name.rawValue) has fallen!")
                    }
                }
            }
            
            // Check if all heroes defeated
            if cardManager.myHeroCards.allSatisfy({ $0.stats.health <= 0 }) {
                battleLog.append("\n💀 Defeat! All heroes have fallen!")
                finalizeBattle()
                return
            }
            
            battleRound += 1
            
            // Continue to next round with delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                executeRound()
            }
        }
        
        executeRound()
    }
    
    private func handleEnemyDefeat(enemyIndex: Int) {
        let defeatedEnemy = cardManager.myEnemyCards[enemyIndex]
        let goldReward = defeatedEnemy.heroClass.level * 10
        gold = Gold(gold: gold.gold + goldReward)
        battleLog.append("Gained \(goldReward) gold!")
    }
    
    private func finalizeBattle() {
        // Clean up defeated enemies
//        cardManager.enemy.removeAll { $0.stats.health <= 0 }
        
        // Hide fighting animation and show battle log
        showFightingAnimation = false
        isBattleInProgress = false
        showBattleLog = true
        
        // Update the UI
        DispatchQueue.main.async {
           
        }
    }
}

// MARK: - Fighting Animation View
struct FightingAnimationView: View {
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0
    @State private var pulseScale: CGFloat = 1.0
    @State private var textOpacity: Double = 1.0
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Animated sword
                ZStack {
                    // Glow effect behind sword
                    Image(systemName: "sword.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.yellow)
                        .opacity(0.3)
                        .scaleEffect(pulseScale * 1.3)
                        .blur(radius: 10)
                    
                    // Main sword
                    Image(systemName: "sword.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(rotationAngle))
                        .scaleEffect(pulseScale)
                        .shadow(color: .yellow, radius: 10)
                }
                .onAppear {
                    startAnimations()
                }
                
                // Fighting text with animated dots
                HStack(spacing: 4) {
                    Text("Fighting")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                    
                    // Animated dots
                    ForEach(0..<3, id: \.self) { index in
                        Text(".")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .opacity(textOpacity)
                            .animation(
                                Animation.easeInOut(duration: 0.8)
                                    .repeatForever()
                                    .delay(Double(index) * 0.2),
                                value: textOpacity
                            )
                    }
                }
                
                // Battle progress indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                    .scaleEffect(1.5)
            }
        }
        .transition(.opacity)
    }
    
    private func startAnimations() {
        // Sword rotation animation
        withAnimation(
            Animation.linear(duration: 2.0)
                .repeatForever(autoreverses: false)
        ) {
            rotationAngle = 360
        }
        
        // Pulse animation
        withAnimation(
            Animation.easeInOut(duration: 1.0)
                .repeatForever(autoreverses: true)
        ) {
            pulseScale = 1.2
        }
        
        // Text opacity animation for dots
        withAnimation(
            Animation.easeInOut(duration: 0.8)
                .repeatForever(autoreverses: true)
        ) {
            textOpacity = 0.3
        }
    }
}

// MARK: - Battle Log View
struct BattleLogView: View {
    let battleLog: [String]
    let onClose: () -> Void
    
    var body: some View {
        VStack {
            Text("Battle Log")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(battleLog, id: \.self) { logEntry in
                        Text(logEntry)
                            .font(.caption)
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
            .frame(maxHeight: 200)
            
            Button("Close") {
                onClose()
            }
            .padding()
            .background(Color.secondary)
            .cornerRadius(8)
        }
        .frame(width: 300, height: 300)
        .background(Color.gray)
        .cornerRadius(15)
    }
}
