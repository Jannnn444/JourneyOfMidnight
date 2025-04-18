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
    @State var eventState: Events
    
    var body: some View {
        ZStack{
                // Background - this will be our clickable area to dismiss
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //               showDetailSkillView = false
                        //               selectedHero = nil
                    }
                // MARK: - Top 1/2 Banner GameBd
                switch eventState {
                case .Game:
                    Rectangle()
                        .frame(width: 500, height: 350)
                        .foregroundColor(.blue.opacity(0.4))
                        .cornerRadius(20)
                case .FortuneWheel:
                    Rectangle()
                        .frame(width: 500, height: 350)
                        .foregroundColor(.brown.opacity(0.4))
                        .cornerRadius(20)
                case .GroceryShop:
                    Rectangle()
                        .frame(width: 500, height: 350)
                        .foregroundColor(.indigo.opacity(0.4))
                        .cornerRadius(20)
                case .Sleep:
                    Rectangle()
                        .frame(width: 500, height: 350)
                        .foregroundColor(.pink.opacity(0.4))
                        .cornerRadius(20)
                case .Forest:
                    Rectangle()
                        .frame(width: 500, height: 350)
                        .foregroundColor(.green.opacity(0.4))
                        .cornerRadius(20)
                }
                
                // MARK: - 2/2 B.Bounced Skill View
                VStack {
                    if selectedHero != nil {
                        VStack(alignment: .leading) {
                            PopupView{
                                Text("\(selectedHero!.heroClass.name.rawValue.capitalized)")
                                    .foregroundStyle(.black)
                                    .font(.headline)
                                    .bold()
                                ForEach(selectedHero!.skills) { skill in
                                    Text("\(skill.name): \(skill.power)")
                                        .foregroundStyle(.black)
                                        .font(.headline)
                                }
                                ForEach(selectedHero!.items) { item in
                                    Text("\(item.name)")
                                        .foregroundStyle(.black)
                                        .font(.headline)
                                }
                                Text("Wisdom: \(String(describing: selectedHero!.attributes.Wisdom))")
                                    .foregroundStyle(.black)
                                    .font(.headline)
                                
                                Button(action: {
                                    cardManager.showMoreDetail = false
                                    selectedHero = nil
                                }) {
                                    Text("Close")
                                        .padding()
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .bold()
                                        .background(Color.secondary)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    } else {
                        // MARK: - 2/2 A.Card View
                        HStack {
                            ForEach(cardManager.hero) { hero in
                                Button(action: {
                                    showDetailSkillView.toggle() // Button for shows brief skill
                                }) {
                                    ZStack {
                                        
                                        Rectangle()
                                            .frame(width: 100, height: 130)
                                            .foregroundColor(.yellow)
                                            .cornerRadius(10)
                                        VStack() {
                                            Text(hero.heroClass.name.rawValue.capitalized)
                                                .font(.headline)
                                                .padding()
                                                .fontDesign(.monospaced)
                                                .bold()
                                            
                                            if showDetailSkillView {
                                                // heres what we gotta do
                                                // makes the view clickable
                                                VStack(alignment: .leading) {
                                                    ForEach(hero.skills) { skill in
                                                        // Have the skills able to be buttons and expand to show more infos
                                                        Button(action: {
                                                            cardManager.showMoreDetail = true
                                                            selectedHero = hero
                                                        }) {
                                                            DetailSkillView(skill: skill)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                    } // Zstack
                                }
                            } // ForEach hero
                            
                        } .position(x: 350, y: 250)
                    } // selectedHero = nil >>> else view shows
                    Button(action: {
                        eventState = shuffleEvents()
                    }) {
                        Text("Shuffle Event")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                    }
                }
            }.padding([.top, .leading, .trailing])
//       .ignoresSafeArea()
    }
}

#Preview {
    HeroMainView(eventState: .Game)
}


