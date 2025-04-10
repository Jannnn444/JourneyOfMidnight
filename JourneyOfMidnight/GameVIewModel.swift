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
    @Published var player : Hero?
    
    var occasions: [Occasion] = []
    
    init() {
        setupOccasions()
        setupPlayerData()
    }
    
    func setupPlayerData() {
        self.player = Hero(
            heroClass:
                HeroClass(name: .fighter, level: 20), 
                attributes:
                Attributes(Strength: 50, Intelligence: 10, Wisdom: 10, Agility: 10, Vitality: 10, Faith: 5, Charisma: 10), 
                skills: [Skill(name: "punch"), Skill(name: "star strike")], 
                items: [Item(name: "armouur"), Item(name:"pants")],
                stats: Stats(health: 100, endurance: 100))
    }
    
    func setupOccasions() {
           occasions = [
               Occasion(
                   level: 0,
                   topic: "The Awakening",
                   description: "You wake up in the ruined chapel of Eldoria, with no memory of your past.",
                   choices: [
                       Choice(text: "Investigate the broken altar") { $0.Wisdom += 1; $0.Faith += 1 },
                       Choice(text: "Search the scattered scrolls") { $0.Intelligence += 2; $0.Strength -= 1 },
                       Choice(text: "Grab the old axe by the door") { $0.Strength += 2; $0.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 1,
                   topic: "The First Encounter",
                   description: "A starving wolf blocks your path in the forest.",
                   choices: [
                       Choice(text: "Offer food to the beast") { $0.Charisma += 1; $0.Wisdom += 1; $0.Vitality -= 1 },
                       Choice(text: "Evade it and hide") { $0.Agility += 2; $0.Strength -= 1 },
                       Choice(text: "Fight it off with a stick") { $0.Strength += 1; $0.Vitality += 1; $0.Intelligence -= 1 }
                   ]
               ),
               Occasion(
                   level: 2,
                   topic: "The Hermit’s Wisdom",
                   description: "You meet a blind hermit who offers you a riddle in exchange for knowledge.",
                   choices: [
                       Choice(text: "Attempt the riddle") { $0.Intelligence += 2; $0.Wisdom += 1; $0.Strength -= 1 },
                       Choice(text: "Ask him to bless you instead") { $0.Faith += 2; $0.Agility -= 1 },
                       Choice(text: "Bribe him for the answer") { $0.Charisma += 1; $0.Faith -= 2 }
                   ]
               ),
               Occasion(
                   level: 3,
                   topic: "Potion of Change",
                   description: "You find a glowing potion labeled 'FOR THE DARING.'",
                   choices: [
                       Choice(text: "Drink it immediately") { $0.Vitality += 1; $0.Agility += 1; $0.Wisdom -= 1 },
                       Choice(text: "Analyze the potion first") { $0.Intelligence += 2; $0.Strength -= 1 },
                       Choice(text: "Ignore it and walk away") { $0.Wisdom += 1; $0.Agility -= 1 }
                   ]
               ),
               Occasion(
                   level: 4,
                   topic: "Town of Thornehelm",
                   description: "You arrive at a bustling medieval town.",
                   choices: [
                       Choice(text: "Join a dance in the town square") { $0.Charisma += 2; $0.Wisdom -= 1 },
                       Choice(text: "Help rebuild the collapsed wall") { $0.Strength += 2; $0.Vitality += 1; $0.Intelligence -= 1 },
                       Choice(text: "Visit the library tower") { $0.Intelligence += 2; $0.Wisdom += 1; $0.Agility -= 2 }
                   ]
               ),
               Occasion(
                   level: 5,
                   topic: "The Haunted Crypt",
                   description: "You explore the ancient crypt beneath the town.",
                   choices: [
                       Choice(text: "Meditate in the silent tomb") { $0.Faith += 1; $0.Wisdom += 2; $0.Vitality -= 1 },
                       Choice(text: "Battle the lurking shadows") { $0.Strength += 2; $0.Vitality += 1; $0.Intelligence -= 2 },
                       Choice(text: "Observe from a distance") { $0.Agility += 1; $0.Intelligence += 1; $0.Strength -= 1 }
                   ]
               ),
               Occasion(
                   level: 6,
                   topic: "Rumors of a Dragon",
                   description: "Tales speak of a dragon atop Mount Glaven.",
                   choices: [
                       Choice(text: "Set off on the journey") { $0.Strength += 1; $0.Vitality += 1; $0.Charisma -= 1 },
                       Choice(text: "Convince a knight to guide you") { $0.Charisma += 2; $0.Wisdom -= 1 },
                       Choice(text: "Study dragon lore first") { $0.Intelligence += 2; $0.Faith += 1; $0.Strength -= 2 }
                   ]
               ),
               Occasion(
                   level: 7,
                   topic: "The Arcane Tower",
                   description: "You gain entry to the wizard’s tower.",
                   choices: [
                       Choice(text: "Learn a forbidden spell") { $0.Intelligence += 2; $0.Faith -= 2 },
                       Choice(text: "Clean and earn his favor") { $0.Faith += 2; $0.Charisma += 1; $0.Vitality -= 1 },
                       Choice(text: "Ignore him and train on your own") { $0.Strength += 1; $0.Agility += 1; $0.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 8,
                   topic: "Duel at Dawn",
                   description: "A challenger demands a duel to test your honor.",
                   choices: [
                       Choice(text: "Accept and fight fairly") { $0.Strength += 2; $0.Vitality += 1; $0.Charisma -= 1 },
                       Choice(text: "Convince him to spare the duel") { $0.Charisma += 2; $0.Strength -= 1 },
                       Choice(text: "Use a sneaky trick to win") { $0.Agility += 2; $0.Intelligence += 1; $0.Faith -= 2 }
                   ]
               ),
               Occasion(
                   level: 9,
                   topic: "The Prophecy",
                   description: "A seer proclaims you are the chosen one.",
                   choices: [
                       Choice(text: "Embrace the prophecy") { $0.Faith += 2; $0.Charisma += 1; $0.Intelligence -= 1 },
                       Choice(text: "Demand proof through logic") { $0.Intelligence += 2; $0.Faith -= 2 },
                       Choice(text: "Laugh it off") { $0.Charisma += 1; $0.Agility += 1; $0.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 10,
                   topic: "The Final Trial",
                   description: "You stand before the Dragon of Glaven.",
                   choices: [
                       Choice(text: "Charge head-on") { $0.Strength += 3; $0.Intelligence -= 2 },
                       Choice(text: "Use everything you’ve learned") { $0.Wisdom += 2; $0.Intelligence += 2; $0.Vitality -= 2 },
                       Choice(text: "Negotiate peace with the beast") { $0.Charisma += 3; $0.Faith += 1; $0.Strength -= 2 }
                   ]
               )
           ]
       }
    
    func choose(_ choice: Choice) async {
        // Simulate async processing delay
        
        try? await Task.sleep(nanoseconds: 500_000_000) // background threads
         
//      choice.consequences(&attributes)  //was published an attribute but now use hero
        DispatchQueue.main.async {
            if var currentHero = self.player {
                choice.consequences(&currentHero.attributes)
                self.player = currentHero // reassign to trigger view updates
            }
            
            if self.level < self.occasions.count - 1 {
                self.level += 1
            }
        }
    }
    
    func restartGame() {
           // Reset the level and other game-related data
           level = 0
           setupOccasions()  // Reinitialize the occasions or other data
       }
    
}
