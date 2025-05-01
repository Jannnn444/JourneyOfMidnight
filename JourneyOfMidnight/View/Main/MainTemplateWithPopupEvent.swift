//
//  MainTemplateWithPopupEvent.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//
//
//  MainTemplateWithPopupEvent.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

struct MainTemplateWithPopupEvent<Content: View, PopupContent: View>: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var eventState: Events
    @Binding var gold: Gold
    
    // The main content to display (like EventCombat, EventVendorShop, or EventForest)
    let content: Content
    
    // Optional popup content
    let popupContent: PopupContent?
    
    // Initialize with event content and popup
    init(content: Content,
         eventState: Binding<Events>,
         gold: Binding<Gold>,
         @ViewBuilder popup: () -> PopupContent) {
        self.content = content
        self._eventState = eventState
        self._gold = gold
        self.popupContent = popup()
    }
    
    var body: some View {
        ZStack {
            // Background
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                // The main content (passed in)
                content
                
                Spacer()
                
                // Hero cards at the bottom all the time
                CardHeroSetView(
                    IsShowDetailSkillView: .constant(false),
                    showMoreDetail: .constant(false),
                    selectedHeros: .constant([])
                )
            }
            
            // Display popup
            popupContent
            
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

// Convenience initializer with no popup - using EmptyView
extension MainTemplateWithPopupEvent where PopupContent == EmptyView {
    init(content: Content, eventState: Binding<Events>, gold: Binding<Gold>) {
        self.init(content: content, eventState: eventState, gold: gold) {
            EmptyView()
        }
    }
}

// Preview provider
struct MainTemplateWithPopupEvent_Previews: PreviewProvider {
    static var previews: some View {
        MainTemplateWithPopupEvent(
            content: EventCombat(),
            eventState: .constant(.combat),
            gold: .constant(Gold(gold: 1000))
        )
    }
}
