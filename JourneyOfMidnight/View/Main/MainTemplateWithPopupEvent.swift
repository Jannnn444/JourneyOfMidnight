//
//  MainTemplateWithPopupEvent.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

// simplest popup view that receives content
struct MainTemplateWithPopupEvent<Content: View>: View {
    // store content
    let content: Content

    @ObservedObject var cardManager = CardManager.shared
    @State private var showDetailSkillViewHero = false
    @State private var showDetailSkillViewEnemi = false
    @State private var showDetailItemView = false
    
    @State private var showMoreDetailEnemi = false
    @State private var showMoreDetailItems = false
    
    @State private var selectedHeros: [Hero] = []
    @State private var selectedEnemies: [Hero] = []
    @State private var selectedItems: [VendorGoods] = []
    
    @State private var eventState: Events = .combat
    @State private var gold: Gold = Gold(gold: 10000)
    @State private var stories: [Story] = []
    
    
      // init with content
      init(@ViewBuilder content: () -> Content) {
          self.content = content()
      }
      
    
    var body: some View {
        ZStack{
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
/*     Color.white
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {}  */
            
            // MARK: - Top 1/2 Banner GameBd (will be pass in)
            content
            
            // Hero View always show
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
