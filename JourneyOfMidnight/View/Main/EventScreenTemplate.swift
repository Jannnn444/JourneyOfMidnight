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
    
    // Event-specific content
    let eventContent: AnyView
    // Event-specific popup content
    let eventPopupContent: AnyView?
    
    // Common state for all event types
    @State private var selectedHeros: [Hero] = []
    @State private var showDetailSkillViewHero: Bool = false
    @State private var showMoreDetailHero: Bool = false
    
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
        
        // Create the combat event content
        self.eventContent = AnyView(
            ZStack {
                EventCombat()
                
                EnemyCardSet(
                    selectedEnemies: selectedEnemies,
                    showDetailSkillViewEnemi: showDetailSkillViewEnemi,
                    showMoreDetailEnemi: showMoreDetailEnemi
                )
            }
        )
        
        // Create event popup content
        self.eventPopupContent = AnyView(
            EnemyCardSetWSkill(
                selectedEnemies: selectedEnemies,
                showDetailSkillViewEnemi: showDetailSkillViewEnemi,
                showMoreDetailEnemi: showMoreDetailEnemi
            )
        )
    }
    
    // For vendor events
    init(
        eventState: Binding<Events>,
        gold: Binding<Gold>,
        selectedItems: Binding<[VendorGoods]>,
        showDetailItemView: Binding<Bool>,
        showMoreDetailItems: Binding<Bool>
    ) {
        self._eventState = eventState
        self._gold = gold
        
        // Create the vendor event content
        self.eventContent = AnyView(
            EventVendorShop(
                IsShowDetailItemView: showDetailItemView,
                showMoreDetail: showDetailItemView,
                selectedItems: selectedItems
            )
        )
        
        // Create event popup content
        self.eventPopupContent = AnyView(
            EventVendorPopup(
                selectedItems: selectedItems,
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
            eventContent
            
            // Hero cards at the bottom
            CardHeroSetView(
                IsShowDetailSkillView: $showDetailSkillViewHero,
                showMoreDetail: $showMoreDetailHero,
                selectedHeros: $selectedHeros
            )
            
            // Hero skills popup
            CardHeroSetViewWSkill(
                selectedHeros: $selectedHeros,
                showDetailSkillView: $showDetailSkillViewHero,
                showMoreDetail: $showMoreDetailHero
            )
            
            // Event-specific popup content if available
            if let popup = eventPopupContent {
                popup
            }
            
            // Next day button
            ButtomButton(eventState: $eventState, textOnButton: "Next Day")
                .padding()
                .padding(.bottom, 40)
            
            // Gold display
            GoldView(gold: $gold)
                .padding()
        }
        .ignoresSafeArea()
    }
}

// MARK: - Usage examples
struct CombatScreenExample: View {
    @State private var eventState: Events = .combat
    @State private var gold: Gold = Gold(gold: 1000)
    @State private var selectedEnemies: [Hero] = []
    @State private var showDetailSkillViewEnemi: Bool = false
    @State private var showMoreDetailEnemi: Bool = false
    
    var body: some View {
        EventScreenTemplate(
            eventState: $eventState,
            gold: $gold,
            selectedEnemies: $selectedEnemies,
            showDetailSkillViewEnemi: $showDetailSkillViewEnemi,
            showMoreDetailEnemi: $showMoreDetailEnemi
        )
    }
}

struct VendorScreenExample: View {
    @State private var eventState: Events = .vendor
    @State private var gold: Gold = Gold(gold: 1500)
    @State private var selectedItems: [VendorGoods] = []
    @State private var showDetailItemView: Bool = false
    @State private var showMoreDetailItems: Bool = false
    
    var body: some View {
        EventScreenTemplate(
            eventState: $eventState,
            gold: $gold,
            selectedItems: $selectedItems,
            showDetailItemView: $showDetailItemView,
            showMoreDetailItems: $showMoreDetailItems
        )
    }
}

struct ForestScreenExample: View {
    @State private var eventState: Events = .inTheWoods
    @State private var gold: Gold = Gold(gold: 2000)
    @State private var stories: [Story] = CardManager.shared.stories
    
    var body: some View {
        EventScreenTemplate(
            eventState: $eventState,
            gold: $gold,
            stories: $stories
        )
    }
}

// Preview provider
struct EventScreenTemplate_Previews: PreviewProvider {
    static var previews: some View {
        ForestScreenExample()
    }
}
