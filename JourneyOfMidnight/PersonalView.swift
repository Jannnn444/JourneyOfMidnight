//
//  PersonalView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/6.
//

import SwiftUI

struct PersonalView: View {
    @ObservedObject var cardmanager = CardManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .trailing) {
                HStack(alignment: .bottom, spacing: 0) {
                    ZStack {
                        VStack {
                            Spacer()
//                            BoardView(characterContent: tempPlayer1)
                            Spacer()
                        }
                        .padding(.horizontal) // Padding Horizontally makes up and down liitle padding
                    }.overlay(
                        Group {
                            if cardmanager.showAbilityDetailView {
                                ZStack {
                                    // ** Blurry background **
                                    Color.black.opacity(0.3)
                                        .cornerRadius(20)
                                        .edgesIgnoringSafeArea(.all)
                                        .onTapGesture {
                                            cardmanager.showAbilityDetailView = false // Tap outside to close
                                        }
                                    
                                    // ** Detail View **
                                    VStack {
                                        AbilityDetailViewPage(skillName: cardmanager.skillName, skillType: cardmanager.skillType)
                                    }
                                    .frame(width: 500, height: 300)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                                    .transition(.scale)
                                    .animation(.easeInOut, value: cardmanager.showAbilityDetailView)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity) // **Full screen overlay**
                            }
                        }
                    ) // Zstack
                   
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Exit")
                            .frame(width: 40, height: 10)
                            .padding()
                            .font(.footnote)
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                } //HStack
            } // VStack
           
        }
    }
}
