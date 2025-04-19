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
    @State var selectedHeros: [Hero] = []
    @State var selectedEnemies: [Hero] = []
    @State var eventState: Events
    
    var body: some View {
        ZStack{
            // Background - this will be our clickable area to dismiss
            Color.white //black
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                }
            // MARK: - Top 1/2 Banner GameBd
            switch eventState {
            case .Game:
                EventGame()
                
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
            
            // MARK: -  Hero Card Set View (CardSet & show skill 2 vers)
            if selectedHeros == [] {
               CardHeroSetView(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillView, showMoreDetail: $showDetailSkillView)
            } else if selectedHeros != [] {
                CardHeroSetViewWSkill(selectedHeros: $selectedHeros, showDetailSkillView: $showDetailSkillView, showMoreDetail: $showDetailSkillView)
            }
            
            // MARK: - Button Shuffle Event
            // Always at bottom right
            // Zstack
            ButtomButton(eventState: $eventState, textOnButton: "Next Day").padding()
        }
        // .padding([.top, .leading, .trailing])
        .ignoresSafeArea()
    }
}


#Preview {
    HeroMainView(eventState: .Game)
}


