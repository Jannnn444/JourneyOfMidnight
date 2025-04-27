//
//  MainMenu.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

enum Navigation {
    case home
    case game
    case queue
}

struct MainMenuView: View {
    @State var navigation: Navigation = .home
    
    var body: some View {
        switch(navigation) {
        case .home:
            Text("home")
            // navigation to go queue
            
            Button(action: {
                navigation = .queue
            }) {
                Text("Find match!")
            }
            
        case .game:
            HeroMainView(eventState: .combat, gold: Gold(gold: 10000), stories: [
                Story(topic: "Waken from an abandoned chapel, you found a body cruelly harmed and passed right next to you. You smell the blood on your hand. ", choice: [Option(option: "Admit your crime", effect: 5, effectType: .Charisma), Option(option: "Wash your hands", effect: 5, effectType: .Wisdom), Option(option: "go back to sleep", effect: 5, effectType: .Agility)]),
                Story(topic: "Unusual mist start gathering in front of you, you sence the creep atmosphere, you turn back, but all you see just white wall...", choice: [Option(option: "Shout all the saint chris name, hope any evils step back and scared", effect: 7, effectType: .Faith), Option(option: "(Sorceror)Natural force to find a path", effect: 4, effectType: .Intelligence), Option(option: "(Dexterity)Listen to where the river shivering", effect: 5, effectType: .Vitality)])
            ])
        case .queue:
            Text("queue")
        }
        
  
    }
    
}
