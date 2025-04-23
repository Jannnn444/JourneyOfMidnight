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
    @State var stories: [Stories]
    
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
                EventForest(stories: $stories) 
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
            
            // MARK: Gold
            GoldView(gold: $gold).padding()
        }
        .ignoresSafeArea()
    }
}




#Preview {
    HeroMainView(eventState: .combat, gold: Gold(gold: 10000), stories: [
        Stories(topic: "Waken from an abandoned chapel, you found a body cruelly harmed and passed right next to you. You smell the blood on your hand. ", choices: [Choice(choice: "Admit your crime", effect: 5, effectType: .Charisma), Choice(choice: "Wash your hands", effect: 5, effectType: .Wisdom), Choice(choice: "go back to sleep", effect: 5, effectType: .Agility)]),
        Stories(topic: "Unusual mist start gathering in front of you, you sence the creep atmosphere, you turn back, but all you see just white wall...", choices: [Choice(choice: "Shout all the saint chris name, hope any evils step back and scared", effect: 7, effectType: .Faith), Choice(choice: "(Sorceror)Natural force to find a path", effect: 4, effectType: .Intelligence), Choice(choice: "(Dexterity)Listen to where the river shivering", effect: 5, effectType: .Vitality)])
    ])
}


