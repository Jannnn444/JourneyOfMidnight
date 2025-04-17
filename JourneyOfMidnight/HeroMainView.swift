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
    
    var body: some View {
        ZStack{
            // Background - this will be our clickable area to dismiss
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    showDetailSkillView = false
                    selectedHero = nil
                }
            
            VStack {
               
                
               
                // MARK: - B. Bounced Skill View
                if selectedHero != nil {
                    VStack(alignment: .leading) {
                        PopupView{
                            Text("\(selectedHero!.heroClass.name.rawValue.capitalized)")
                                    .foregroundStyle(.black)
                                    .font(.caption2)
                            ForEach(selectedHero!.skills) { skill in
                                Text("\(skill.name): \(skill.power)")
                                    .foregroundStyle(.black)
                                    .font(.caption2)
                            }
                            ForEach(selectedHero!.items) { item in
                                Text("\(item.name)")
                                    .foregroundStyle(.black)
                                    .font(.caption2)
                            }
                            Text("Wisdom: \(String(describing: selectedHero!.attributes.Wisdom))")
                                .foregroundStyle(.black)
                                .font(.caption2)
                            
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
                                        
                                        // MARK: - A. Main Card View
                                        if showDetailSkillView {
                                            // heres what we gotta do
                                            // makes the view clickable
                                            VStack(alignment: .leading) {
                                                ForEach(hero.skills) { skill in
                                                    // HAve the skills able to be buttons and expand to show more infos
                                                    Button(action: {
                                                        cardManager.showMoreDetail = true
                                                        selectedHero = hero
                                                        //                                                      selectedSkills = hero.skills
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


