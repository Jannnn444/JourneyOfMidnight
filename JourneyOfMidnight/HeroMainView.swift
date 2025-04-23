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
            Color.white
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {}
            
            // MARK: - Top 1/2 Banner GameBd
            switch eventState {
            case .combat:
                EventCombat()
                EnemyCardSet(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
                CardHeroSetView(IsShowDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero, selectedHeros: $selectedHeros)
                Spacer()
                
            case .vendor:
                EventVendorShop(IsShowDetailItemView: $showDetailItemView, showMoreDetail: $showDetailItemView, selectedItems: $selectedItems)
                CardHeroSetView(IsShowDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero, selectedHeros: $selectedHeros)
                Spacer()
                
            case .inTheWoods:
                EventForest(stories: $stories) 
                Spacer()
                
            }
            
            // MARK: PopUp (Hero & Enemy &Grocery)
            CardHeroSetViewWSkill(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero)
            EnemyCardSetWSkill(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
            EventVendorPopup(selectedItems: $selectedItems, showDetailSkillView: $showDetailItemView, showMoreDetailItems: $showDetailItemView) 
            
            // MARK: Shuffle Button
            ButtomButton(eventState: $eventState, textOnButton: "Next Day").padding()
            
            // MARK: Gold
            GoldView(gold: $gold).padding()
        }
        .ignoresSafeArea()
    }
}




