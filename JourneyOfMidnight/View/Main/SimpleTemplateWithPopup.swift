//
//  SimpleTemplateWithPopup.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

// A simplified version of the MainTemplateWithPopupEvent that doesn't use generic types
struct SimpleTemplateWithPopup: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var eventState: Events
    @Binding var gold: Gold
    
    // Content is provided as ViewBuilder closures
    let mainContent: () -> AnyView
    let popupContent: () -> AnyView
    let showPopup: Bool
    
    init(
        eventState: Binding<Events>,
        gold: Binding<Gold>,
        showPopup: Bool = false,
        @ViewBuilder mainContent: @escaping () -> some View,
        @ViewBuilder popupContent: @escaping () -> some View = { EmptyView() }
    ) {
        self._eventState = eventState
        self._gold = gold
        self.showPopup = showPopup
        self.mainContent = { AnyView(mainContent()) }
        self.popupContent = { AnyView(popupContent()) }
    }
    
    var body: some View {
        ZStack {
            // Background
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                // The main content
                mainContent()
                
                Spacer()
                
                // Hero cards at the bottom
                CardHeroSetView(
                    IsShowDetailSkillView: .constant(false),
                    showMoreDetail: .constant(false),
                    selectedHeros: .constant([])
                )
            }
            
            // Display popup if showPopup is true
            if showPopup {
                popupContent()
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

// MARK: - Example usage
struct SimpleTemplateExample: View {
    @State private var eventState: Events = .combat
    @State private var gold: Gold = Gold(gold: 1000)
    @State private var showPopup: Bool = false
    
    var body: some View {
        SimpleTemplateWithPopup(
            eventState: $eventState,
            gold: $gold,
            showPopup: showPopup,
            mainContent: {
                // Main content
                EventCombat()
            },
            popupContent: {
                // Popup content
                Text("This is a popup!")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        )
    }
}

// Preview provider
struct SimpleTemplateWithPopup_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTemplateExample()
    }
}
