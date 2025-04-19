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
    @State var eventState: Events
    @State var hoveredHero: Hero? = nil
    
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
                Rectangle()
                    .frame(width: 500, height: 350)
                    .foregroundColor(.blue.opacity(0.8))
                    .cornerRadius(20)
                Image("banner")
                    .frame(width: 400, height: 200)
                    .padding()
                VStack {
                    HStack {
                        Image("fight")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Battle For Glory")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    } .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                }
         
                
                Spacer()
                
            case .FortuneWheel:
                Rectangle()
                    .frame(width: 500, height: 350)
                    .foregroundColor(.brown.opacity(0.8))
                    .cornerRadius(20)
                Image("banner")
                    .frame(width: 400, height: 200)
                    .padding()
                VStack {
                    HStack {
                        Image("castle")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Spin Your Fortune Wheel")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    } .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                }
      
                Spacer()
            case .GroceryShop:
                Rectangle()
                    .frame(width: 500, height: 350)
                    .foregroundColor(.indigo.opacity(0.8))
                    .cornerRadius(20)
                Image("banner")
                    .frame(width: 400, height: 200)
                    .padding()
                VStack {
                    HStack {
                        Image("vendor")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Vendor")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    } .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                }
                Spacer()
            case .Sleep:
                Rectangle()
                    .frame(width: 500, height: 350)
                    .foregroundColor(.pink.opacity(0.8))
                    .cornerRadius(20)
                Image("banner")
                    .frame(width: 400, height: 200)
                    .padding()
                VStack { 
                    HStack {
                        Image("campfire")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Rest Recharge")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    } .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                }
                    
                Spacer()
            case .Forest:
                Rectangle()
                    .frame(width: 500, height: 350)
                    .foregroundColor(.green.opacity(0.8))
                    .cornerRadius(20)
                Image("banner")
                    .frame(width: 400, height: 200)
                    .padding()
                VStack {
                    HStack {
                        Image("forest")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Adventure Forest")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                    } .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                    Spacer()
                }
             
                Spacer()
            }
            
            // MARK: - 2/2 B.Bounced Skill View
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
            } else if selectedHeros == [] {
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


