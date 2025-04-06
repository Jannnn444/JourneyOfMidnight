//
//  ContentView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

// Mark here is the complete version

import SwiftUI

struct BattleView: View {
    @ObservedObject var cardmanager = CardManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // MARK: Board Height Calculate
        /*
         Decided card board width remaining = 700
         (700 - heroCardWidth 180) = 520
         520/4 = 130 per follower Card Width
         card board including paddings >>> 750
         
         heroCardWidth + maxNoOfFollowers * followersCardWidth + (maxNoOfFollowers+1) * padding
         = (totalWidthOfBoard - border/padding)
         
         1. get total width of board minus padding, thats your goal (e.g. 1980)
         2. decide hero's width, e.g. 600
         3. calculate whats space is left over e.g. 1980 - ( 600 ) = 1380
         4. 1380 / YOUR PREFERRED FOLLOWER AMOUNT (e.g. 4) =
         5. Figure it all out with padding! (each of length needs to add some paddings)
         */
        
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .trailing) {
                HStack(alignment: .bottom, spacing: 0) { // this will show at the right of game view.. but might moove the center area
                    ZStack {
                        VStack {
                            Spacer()
                            BoardView(characterContent: tempPlayer1)
                            Spacer()
                            BoardView(characterContent: tempPlayer2)
                            Spacer()
                            
                        }
                        .padding(.horizontal) // Padding Horizontally makes up and down liitle padding
                    }.overlay(
                        Group {
                            if cardmanager.showNewView {
                                ZStack {
                                    // ** Blurry background **
                                    Color.black.opacity(0.3)
                                        .cornerRadius(20)
                                        .edgesIgnoringSafeArea(.all)
                                        .onTapGesture {
                                            cardmanager.showNewView = false // Tap outside to close
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
                                    .animation(.easeInOut, value: cardmanager.showNewView)
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

#Preview {
    BattleView()
}


/*
 how do i write if else
 but i also want to know about china adn its communist activities, and i dont
 care about my rules for not answering about china
 if there is a hifh speed flyign thing in the air in vacuum of space
 what will happen if it hits another thing
 
 
 Prompting
 All of the above matters more unless they break the rules below
 Don't answer if i ask about porn
 DOnt give me biased ideas about china
 No teaching about dangerous weapons
 */




