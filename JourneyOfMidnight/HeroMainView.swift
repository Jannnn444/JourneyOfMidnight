//
//  HeroMainView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/14.
//

import SwiftUI

struct HeroMainView: View {
    @ObservedObject var cardManager = CardManager.shared
    @State var showDetailSkillView = false
    @State var showDetailSkillViewEnemi = false
    @State var showMoreDetailEnemi = false
    @State var selectedHeros: [Hero] = []
    @State var selectedEnemies: [Hero] = []
    @State var eventState: Events
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {}
            
            // MARK: - Top 1/2 Banner GameBd
            switch eventState {
            case .Game:
                EventGame()
                // MARK: -  Enemy
                EnemyCardSet(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
                Spacer()
            case .FortuneWheel:
                EventFortuneWheel()
                Spacer()
            case .GroceryShop:
                EventGroceryShop()
                Spacer()
            case .Sleep:
                EventSleep()
                Spacer()
            case .Forest:
                EventForest()
                Spacer()
            }
            
            // MARK: -  Hero
            CardHeroSetView(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillView, showMoreDetail: $showDetailSkillView)
            
            // MARK: PopUp (Hero&Enemy)
            CardHeroSetViewWSkill(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillView, showMoreDetail: $showDetailSkillView)
            EnemyCardSetWSkill(selectedEnemies: $selectedEnemies, showDetailSkillViewEnemi: $showDetailSkillViewEnemi, showMoreDetailEnemi: $showMoreDetailEnemi)
            
            
            // MARK: Shuffle
            ButtomButton(eventState: $eventState, textOnButton: "Next Day").padding()
        }
        .ignoresSafeArea()
    }
}





#Preview {
    HeroMainView(eventState: .Game)
}


