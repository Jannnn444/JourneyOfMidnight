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
    @State var selectedHeros: [Hero] = []
    @State var selectedEnemies: [Hero] = []
    @State var eventState: Events
    
    var body: some View {
        ZStack{
            // Background - this will be our clickable area to dismiss
            Color.white //black
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                }
            // MARK: - Top 1/2 Banner GameBd
            switch eventState {
            case .Game:
                EventGame()
                
                Spacer()
                
            case .FortuneWheel:
                EventFortuneWheel()
                Spacer()
            case .GroceryShop:
                EventGroceryShop()
                Spacer()
            case .Sleep:
                EventSleep()
                Spacer()
            case .Forest:
                EventForest()
                Spacer()
            }
            
            // MARK: - B.BounceUp Skill View
            if selectedHeros != [] {
                VStack(alignment: .leading) {
                    ForEach(selectedHeros) { hero in
                    PopupView{
                        Text("\(hero.heroClass.name.rawValue.capitalized)")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .bold()
                       
                            ForEach(hero.skills) { skill in
                                Text("\(skill.name): \(skill.power)")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                            ForEach(hero.items) { item in
                                Text("\(item.name)")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                            Text("Wisdom: \(String(describing: hero.attributes.Wisdom))")
                                .foregroundStyle(.white)
                                .font(.headline)
                            
                        }
                       
                        Button(action: {
                            cardManager.showMoreDetail = false
                            selectedHeros = []
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
                // MARK: - A.Card View
            } else if selectedHeros == [] {
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
                                    
                                    var myHero = hero.heroClass.name
                                    if myHero == HeroClassName.fighter {
                                        Image("knight")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } else if myHero == HeroClassName.wizard {
                                        Image("princess")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } else if myHero == HeroClassName.priest {
                                        Image("priest")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } else if myHero == HeroClassName.duelist {
                                        Image("duelist")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } else if myHero == HeroClassName.rogue {
                                        Image("rogue")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } else if myHero == HeroClassName.templar {
                                        Image("templar")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    
                                    Text(hero.heroClass.name.rawValue.capitalized)
                                        .font(.headline)
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
                                                    selectedHeros.append(hero)
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
                    
                } .position(x: 410, y: 300)
            } // selectedHero = nil >>> else view shows
            
            // MARK: - Shuffle Event Button - Always at bottom right
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        eventState = shuffleEvents()
                    }) {
                        Text("Shuffle Event")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                }
            }
        }
        //         .padding([.top, .leading, .trailing])
        .ignoresSafeArea()
        
    }
}


#Preview {
    HeroMainView(eventState: .Game)
}


