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
//  @ObservedObject var attributes: Attributes
    @ObservedObject var attributes: Attributes = Attributes()
    
    var occasions: [Occasion] = []
    
    init() {
        setupOccasions()
        setupPlayerData()
    }
    
    func setupPlayerData() {
        self.player = Hero(
            heroClass:
                HeroClass(name: .fighter, level: 20), 
                attributes: self.attributes,
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
                    Choice(text: "Investigate the broken altar") { _ in self.player?.attributes.Wisdom += 1; self.player?.attributes.Faith += 1 },
                    Choice(text: "Search the scattered scrolls") { _ in self.player?.attributes.Intelligence += 2; self.player?.attributes.Strength -= 1 },
                    Choice(text: "Grab the old axe by the door") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 1,
                   topic: "The First Encounter",
                   description: "A starving wolf blocks your path in the forest.",
                   choices: [
                       Choice(text: "Offer food to the beast") { _ in self.player?.attributes.Wisdom += 1; self.player?.attributes.Faith += 1 },
                       Choice(text: "Evade it and hide") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                       Choice(text: "Fight it off with a stick") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1  }
                   ]
               ),
               Occasion(
                   level: 2,
                   topic: "The Hermit’s Wisdom",
                   description: "You meet a blind hermit who offers you a riddle in exchange for knowledge.",
                   choices: [
                    Choice(text: "Attempt the riddle") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Ask him to bless you instead") {_ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Bribe him for the answer") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 3,
                   topic: "Potion of Change",
                   description: "You find a glowing potion labeled 'FOR THE DARING.'",
                   choices: [
                    Choice(text: "Drink it immediately") {_ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Analyze the potion first") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Ignore it and walk away") {_ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 4,
                   topic: "Town of Thornehelm",
                   description: "You arrive at a bustling medieval town.",
                   choices: [
                    Choice(text: "Join a dance in the town square") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Help rebuild the collapsed wall") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Visit the library tower") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 5,
                   topic: "The Haunted Crypt",
                   description: "You explore the ancient crypt beneath the town.",
                   choices: [
                    Choice(text: "Meditate in the silent tomb") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Battle the lurking shadows") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Observe from a distance") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 6,
                   topic: "Rumors of a Dragon",
                   description: "Tales speak of a dragon atop Mount Glaven.",
                   choices: [
                    Choice(text: "Set off on the journey") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Convince a knight to guide you") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Study dragon lore first") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 7,
                   topic: "The Arcane Tower",
                   description: "You gain entry to the wizard’s tower.",
                   choices: [
                    Choice(text: "Learn a forbidden spell") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Clean and earn his favor") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Ignore him and train on your own") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 8,
                   topic: "Duel at Dawn",
                   description: "A challenger demands a duel to test your honor.",
                   choices: [
                    Choice(text: "Accept and fight fairly") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Convince him to spare the duel") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Use a sneaky trick to win") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 9,
                   topic: "The Prophecy",
                   description: "A seer proclaims you are the chosen one.",
                   choices: [
                    Choice(text: "Embrace the prophecy") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Demand proof through logic") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Laugh it off") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               ),
               Occasion(
                   level: 10,
                   topic: "The Final Trial",
                   description: "You stand before the Dragon of Glaven.",
                   choices: [
                    Choice(text: "Charge head-on") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Use everything you’ve learned") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 },
                    Choice(text: "Negotiate peace with the beast") { _ in self.player?.attributes.Strength += 2; self.player?.attributes.Wisdom -= 1 }
                   ]
               )
           ]
       }
    
    func choose(_ choice: Choice) async {
        try? await Task.sleep(nanoseconds: 500_000_000) // background threads
        
        DispatchQueue.main.async {
            if let attributes = self.player?.attributes {
                choice.consequences(&self.attributes)
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



