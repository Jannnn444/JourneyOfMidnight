//
//  ContentView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        var cardHeight: CGFloat = 150
        var cardWidth: CGFloat = 130
        var heroCardWidth: CGFloat = 180
        var bkgWidth: CGFloat = 700
        var bkgHeight: CGFloat = 170
        
        /*
         heroCardWidth + maxNoOfFollowers * followersCardWidth + (maxNoOfFollowers+1) * padding  = (totalWidthOfBoard - border/padding)
         
    
         1. get total width of board minus padding, thats your goal (e.g. 1980)
         2. decide hero's width, e.g. 600
         3. calculate whats space is left over e.g. 1980 - ( 600 ) = 1380
         4. 1380 / YOUR PREFERRED FOLLOWER AMOUNT (e.g. 4) =
         5. Figure it all out with padding! (each of length needs to add some paddings)
         */
        
        Text("Journey of midnight")
        VStack {
            ZStack{
                // Background Area
                Rectangle()
                    .frame(width: bkgWidth, height: bkgHeight)
                    .cornerRadius(30)
                // Card display area
                HStack {
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: heroCardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                }
            }
            Spacer()
            ZStack {
                // Background Area
                Rectangle()
                    .frame(width: bkgWidth, height: bkgHeight)
                    .cornerRadius(30)
                // Card display area
                HStack {
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: heroCardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                }
            }
        }
        .padding(.horizontal) // Padding Horizontally makes up and down liitle padding
    }
}

#Preview {
    ContentView()
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
