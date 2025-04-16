//
//  HeroMainView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/14.
//

import SwiftUI

struct HeroMainView: View {
    @ObservedObject var cardManager = CardManager.shared
    @State var showDetailSkillView = false
    @State var selectedHero: Hero? = nil
    @State var selectedSkills: [Skill] = []
    
    var body: some View {
        ZStack{
            // Background - this will be our clickable area to dismiss
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    showDetailSkillView = false
                    selectedHero = nil
                    selectedSkills = []
                }
            
            VStack {
                Text("Hero Main Page")
                    .font(.title)
                    .padding()
                
                /*
                 Cards Properties we can use:
                 
                 Text("Hero name: \(cardManager.hero.heroClass.name.rawValue)")
                 Text("Hero level: \(cardManager.hero.heroClass.level)")
                 Text("Hero Attributes Charisma:  \(cardManager.hero.attributes.Charisma)")
                 ForEach(cardManager.hero.skills) { skill in
                 Text("Hero Skill: \(skill.name.capitalized)") }
                 ForEach(cardManager.hero.items) { item in
                 Text("Hero Skill: \(item.name.capitalized)")
                 Text("Hero status: \(cardManager.hero.stats.health)") }
                 
                 */
                // B View
                if selectedHero != nil {
                    VStack(alignment: .leading) {
                        PopupView{
                            ForEach(selectedSkills) { skill in
                                Text("\(skill.name): \(skill.power)")
                                    .foregroundStyle(.black)
                                    .font(.caption2)
                            }
                            
                            Button(action: {
                                cardManager.showMoreDetail = false
                                selectedHero = nil
                            }) {
                                Text("Close")
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Color.secondary)
                                    .cornerRadius(10)
                            }
                        }.padding()
                        
                    }
                } else {
                    
                    // Design the display cards
                    HStack {
                        ForEach(cardManager.hero) { hero in
                            
                            Button(action: {
                                showDetailSkillView = true
                            }) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 100, height: 130)
                                        .foregroundColor(.yellow)
                                        .cornerRadius(20)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(hero.heroClass.name.rawValue.capitalized)
                                            .font(.headline)
                                            .padding()
                                            .fontDesign(.monospaced)
                                            .bold()
                                        // A View
                                        if showDetailSkillView {
                                            // heres what we gotta do
                                            // makes the view clickable
                                            VStack(alignment: .leading) {
                                                ForEach(hero.skills) { skill in
                                                    // HAve the skills able to be buttons and expand to show more infos
                                                    Button(action: {
                                                        cardManager.showMoreDetail = true
                                                        selectedHero = hero
                                                        selectedSkills = hero.skills
                                                    }) {
                                                        DetailSkillView(skill: skill)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    } // Vstack yellow column
                                    
                                } // Zstack
                            }
                        }
                        
                    } //Hstack
                } // selected = nil >>> else view shows
            }
        }
    }
}

#Preview {
    HeroMainView()
}
