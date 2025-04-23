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
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {}
            
            // MARK: - Top 1/2 Banner GameBd
            switch eventState {
            case .combat:
                EventGame()
                // MARK: -  Enemy
                EnemyCardSet(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
                Spacer()
            case .vendor:
                EventGroceryShop(IsShowDetailItemView: $showDetailItemView, showMoreDetail: $showDetailItemView, selectedItems: $selectedItems)
                Spacer()
            case .inTheWoods:
                EventForest() 
                Spacer()
            }
            
            // MARK: -  Hero
            CardHeroSetView(IsShowDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero, selectedHeros: $selectedHeros)
            
            // MARK: PopUp (Hero & Enemy &Grocery)
            CardHeroSetViewWSkill(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillViewHero, showMoreDetail: $showDetailSkillViewHero)
            EnemyCardSetWSkill(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
            EventGroceryPopup(selectedItems: $selectedItems, showDetailSkillView: $showDetailItemView, showMoreDetailItems: $showDetailItemView) 
            
            // MARK: Shuffle Button
            ButtomButton(eventState: $eventState, textOnButton: "Next Day").padding()
            GoldView(gold: $gold).padding()
        }
        .ignoresSafeArea()
    }
}




#Preview {
    HeroMainView(eventState: .combat, gold: Gold(gold: 10000))
}


