//
//  ContentView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        // MARK: Board Height Calculate
        /*
         Decided card board width remaining = 700
         (700 - heroCardWidth 180) = 520
         520/4 = 130 per follower Card Width
         card board including paddings >>> 750
         
         heroCardWidth + maxNoOfFollowers * followersCardWidth + (maxNoOfFollowers+1) * padding  = (totalWidthOfBoard - border/padding)
         
         1. get total width of board minus padding, thats your goal (e.g. 1980)
         2. decide hero's width, e.g. 600
         3. calculate whats space is left over e.g. 1980 - ( 600 ) = 1380
         4. 1380 / YOUR PREFERRED FOLLOWER AMOUNT (e.g. 4) =
         5. Figure it all out with padding! (each of length needs to add some paddings)
         */
        
        Text("Journey of midnight")
            .foregroundStyle(.lightBlue)
        
        VStack {
            BoardView()
            Spacer()
            BoardView(characterContent: [
                Character(name: "JanMan", type: .hero),
                Character(name: "KranMan", type: .follower)
            ])
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


