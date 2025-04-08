//
//  GameVIewModel.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/8.
//

import Foundation
import SwiftUI

class GameVIewModel: ObservableObject {
    @Published var level: Int = 0
    @Published var attributes = Attributes()
    
    var occasions: [Occasion] = []
    
    init() {
        setupOccasions()
    }
    
    func setupOccasions() {
           occasions = [
               Occasion(
                   level: 0,
                   title: "The Awakening",
                   description: "You wake up in the ruined chapel of Eldoria, with no memory of your past.",
                   choices: [
                       Choice(text: "Investigate the broken altar") { $0.Wisdom += 1; $0.Faith += 1 },
                       Choice(text: "Search the scattered scrolls") { $0.Intelligence += 2; $0.Strength -= 1 },
                       Choice(text: "Grab the old axe by the door") { $0.Strength += 2; $0.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 1,
                   title: "The First Encounter",
                   description: "A starving wolf blocks your path in the forest.",
                   choices: [
                       Choice(text: "Offer food to the beast") { $0.Charisma += 1; $0.Wisdom += 1; $0.Vitality -= 1 },
                       Choice(text: "Evade it and hide") { $0.Agility += 2; $0.Strength -= 1 },
                       Choice(text: "Fight it off with a stick") { $0.Strength += 1; $0.Vitality += 1; $0.Intelligence -= 1 }
                   ]
               ),
               Occasion(
                   level: 2,
                   title: "The Hermit’s Wisdom",
                   description: "You meet a blind hermit who offers you a riddle in exchange for knowledge.",
                   choices: [
                       Choice(text: "Attempt the riddle") { $0.Intelligence += 2; $0.Wisdom += 1; $0.Strength -= 1 },
                       Choice(text: "Ask him to bless you instead") { $0.Faith += 2; $0.Agility -= 1 },
                       Choice(text: "Bribe him for the answer") { $0.Charisma += 1; $0.Faith -= 2 }
                   ]
               ),
               Occasion(
                   level: 3,
                   title: "Potion of Change",
                   description: "You find a glowing potion labeled 'FOR THE DARING.'",
                   choices: [
                       Choice(text: "Drink it immediately") { $0.Vitality += 1; $0.Agility += 1; $0.Wisdom -= 1 },
                       Choice(text: "Analyze the potion first") { $0.Intelligence += 2; $0.Strength -= 1 },
                       Choice(text: "Ignore it and walk away") { $0.Wisdom += 1; $0.Agility -= 1 }
                   ]
               ),
               Occasion(
                   level: 4,
                   title: "Town of Thornehelm",
                   description: "You arrive at a bustling medieval town.",
                   choices: [
                       Choice(text: "Join a dance in the town square") { $0.Charisma += 2; $0.Wisdom -= 1 },
                       Choice(text: "Help rebuild the collapsed wall") { $0.Strength += 2; $0.Vitality += 1; $0.Intelligence -= 1 },
                       Choice(text: "Visit the library tower") { $0.Intelligence += 2; $0.Wisdom += 1; $0.Agility -= 2 }
                   ]
               ),
               Occasion(
                   level: 5,
                   title: "The Haunted Crypt",
                   description: "You explore the ancient crypt beneath the town.",
                   choices: [
                       Choice(text: "Meditate in the silent tomb") { $0.Faith += 1; $0.Wisdom += 2; $0.Vitality -= 1 },
                       Choice(text: "Battle the lurking shadows") { $0.Strength += 2; $0.Vitality += 1; $0.Intelligence -= 2 },
                       Choice(text: "Observe from a distance") { $0.Agility += 1; $0.Intelligence += 1; $0.Strength -= 1 }
                   ]
               ),
               Occasion(
                   level: 6,
                   title: "Rumors of a Dragon",
                   description: "Tales speak of a dragon atop Mount Glaven.",
                   choices: [
                       Choice(text: "Set off on the journey") { $0.Strength += 1; $0.Vitality += 1; $0.Charisma -= 1 },
                       Choice(text: "Convince a knight to guide you") { $0.Charisma += 2; $0.Wisdom -= 1 },
                       Choice(text: "Study dragon lore first") { $0.Intelligence += 2; $0.Faith += 1; $0.Strength -= 2 }
                   ]
               ),
               Occasion(
                   level: 7,
                   title: "The Arcane Tower",
                   description: "You gain entry to the wizard’s tower.",
                   choices: [
                       Choice(text: "Learn a forbidden spell") { $0.Intelligence += 2; $0.Faith -= 2 },
                       Choice(text: "Clean and earn his favor") { $0.Faith += 2; $0.Charisma += 1; $0.Vitality -= 1 },
                       Choice(text: "Ignore him and train on your own") { $0.Strength += 1; $0.Agility += 1; $0.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 8,
                   title: "Duel at Dawn",
                   description: "A challenger demands a duel to test your honor.",
                   choices: [
                       Choice(text: "Accept and fight fairly") { $0.Strength += 2; $0.Vitality += 1; $0.Charisma -= 1 },
                       Choice(text: "Convince him to spare the duel") { $0.Charisma += 2; $0.Strength -= 1 },
                       Choice(text: "Use a sneaky trick to win") { $0.Agility += 2; $0.Intelligence += 1; $0.Faith -= 2 }
                   ]
               ),
               Occasion(
                   level: 9,
                   title: "The Prophecy",
                   description: "A seer proclaims you are the chosen one.",
                   choices: [
                       Choice(text: "Embrace the prophecy") { $0.Faith += 2; $0.Charisma += 1; $0.Intelligence -= 1 },
                       Choice(text: "Demand proof through logic") { $0.Intelligence += 2; $0.Faith -= 2 },
                       Choice(text: "Laugh it off") { $0.Charisma += 1; $0.Agility += 1; $0.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 10,
                   title: "The Final Trial",
                   description: "You stand before the Dragon of Glaven.",
                   choices: [
                       Choice(text: "Charge head-on") { $0.Strength += 3; $0.Intelligence -= 2 },
                       Choice(text: "Use everything you’ve learned") { $0.Wisdom += 2; $0.Intelligence += 2; $0.Vitality -= 2 },
                       Choice(text: "Negotiate peace with the beast") { $0.Charisma += 3; $0.Faith += 1; $0.Strength -= 2 }
                   ]
               )
           ]
       }
    
    func choose(_ choice: Choice) {
        choice.effects(&attributes)
        if level < occasions.count - 1 {
             level += 1
        }
    }
    
}
