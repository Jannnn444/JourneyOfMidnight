//
//  EventScreenTemplate.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/5/1.
//

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
        selectedItem: Binding<Item?>,
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
            
            VStack {
                HStack {
                    Spacer()
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
                        Button(action: {
                            // attack func
                        }) {
                            Text("Attack")
                                .padding()
                                .fontDesign(.monospaced)
                                .background(Color.fromHex(selectedColorName).opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(10)
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
            
            if(self.showBagView) {
                PopupView(content: {
                    BagView(gold: gold, itemInMyBag: cardManager.itemInMyBag, selectedHeroBag: cardManager.itemInMyBagByHero)
                })
            }
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
    @State private var selectedItem: Item? = nil
    @State private var showDetailItemView: Bool = false
    @State private var showMoreDetailItems: Bool = false
    
    var body: some View {
        EventScreenTemplate(
            eventState: $eventState,
            gold: $gold,
            selectedItem: $selectedItem,
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
