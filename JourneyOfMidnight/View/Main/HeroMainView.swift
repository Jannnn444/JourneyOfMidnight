//
//  HeroMainView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/14.
//

import SwiftUI

struct HeroMainView: View {
    @ObservedObject var cardManager = CardManager.shared
    @State var showDetailSkillViewHero = false
    @State var showDetailSkillViewEnemi = false
    @State var showDetailItemView = false
    
    @State var showMoreDetailEnemi = false
    @State var showMoreDetailItems = false
    
    @State var selectedHeros: [Hero] = []
    @State var selectedEnemies: [Hero] = []
    @State var selectedItems: [VendorGoods] = []
    
    @State var eventState: Events
    @State var gold: Gold
    @State var stories: [Story] 
    
    var body: some View {
        ZStack{
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
/*     Color.white .ignoresSafeArea() .contentShape(Rectangle()) .onTapGesture {}  */
            
            // MARK: - Top 1/2 Banner GameBd
            switch eventState {
            case .combat:
                EventCombat()
                EnemyCardSet(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi) 
                Spacer()
                
            case .vendor:
                EventVendorShop(IsShowDetailItemView: $showDetailItemView, showMoreDetail: $showDetailItemView, selectedItems: $selectedItems)
                Spacer()
                
            case .inTheWoods:
                EventForest(stories: $stories) 
                Spacer()
            }
            
            CardHeroSetView(IsShowDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero, selectedHeros: $selectedHeros)
            
            // MARK: PopUp (Hero & Enemy &Grocery)
            CardHeroSetViewWSkill(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero)
            EnemyCardSetWSkill(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
            EventVendorPopup(selectedItems: $selectedItems, showDetailSkillView: $showDetailItemView, showMoreDetailItems: $showDetailItemView) 
            
            // MARK: Shuffle Button
            ButtomButton(eventState: $eventState, textOnButton: "Next Day").padding().padding(.bottom, 40)
            
            // MARK: Gold
            GoldView(gold: $gold).padding()
        }
        .ignoresSafeArea()
    }
}




// Example of how to use the MainTemplateWithPopupEvent in different contexts

// MARK: - Combat Example
struct CombatEventExample: View {
    @State private var eventState: Events = .combat
    @State private var gold: Gold = Gold(gold: 1000)
    @State private var selectedEnemies: [Hero] = []
    @State private var showDetailSkillViewEnemi: Bool = false
    @State private var showMoreDetailEnemi: Bool = false
    
    var body: some View {
        // Basic usage without popup (EmptyView is used implicitly)
        MainTemplateWithPopupEvent(
            
            content: 
                ZStack {
                // Main combat event content
                EventCombat()
                
                // Enemy cards
                EnemyCardSet(
                    selectedEnemies: $selectedEnemies,
                    showDetailSkillViewEnemi: $showDetailSkillViewEnemi,
                    showMoreDetailEnemi: $showMoreDetailEnemi
                )
            },
            eventState: $eventState,
            gold: $gold
        )
    }
}

// MARK: - Vendor Example with Popup
struct VendorEventExample: View {
    @State private var eventState: Events = .vendor
    @State private var gold: Gold = Gold(gold: 1500)
    @State private var selectedItems: [VendorGoods] = []
    @State private var showDetailItemView: Bool = false
    @State private var showMoreDetailItems: Bool = false
    
    var body: some View {
        // Usage with popup content
        MainTemplateWithPopupEvent(
            content: EventVendorShop(
                IsShowDetailItemView: $showDetailItemView,
                showMoreDetail: $showDetailItemView,
                selectedItems: $selectedItems
            ),
            eventState: $eventState,
            gold: $gold,
            popup: {
                // Use Group with conditional content for the popup
                Group {
                    if !selectedItems.isEmpty && showMoreDetailItems {
                        EventVendorPopup(
                            selectedItems: $selectedItems,
                            showDetailSkillView: $showDetailItemView,
                            showMoreDetailItems: $showMoreDetailItems
                        )
                    } else {
                        EmptyView()
                    }
                }
            }
        )
    }
}

// MARK: - Forest Story Example
struct ForestEventExample: View {
    @State private var eventState: Events = .inTheWoods
    @State private var gold: Gold = Gold(gold: 2000)
    @State private var stories: [Story] = CardManager.shared.stories
    
    var body: some View {
        // Basic usage without popup content
        MainTemplateWithPopupEvent(
            content: EventForest(stories: $stories),
            eventState: $eventState,
            gold: $gold
        )
    }
}

// Preview provider
struct TemplateUsageExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CombatEventExample()
                .previewDisplayName("Combat Event")
            
            VendorEventExample()
                .previewDisplayName("Vendor Event")
            
            ForestEventExample()
                .previewDisplayName("Forest Event")
        }
    }
}
