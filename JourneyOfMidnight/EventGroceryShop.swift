//
//  EventGroceryShop.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EventGroceryShop: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedItem: [Item]
    @Binding var showDetailSkillView: Bool
//    @binding var showMoreDetail: Bool -> do we need popup here?
    
    var body: some View {
        // MARK: - Banner and Event title
        VStack {
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
                    Text("Vendor Ware")
                        .font(.title)
                        .bold()
                        .fontDesign(.monospaced)
                        .foregroundStyle(.black)
                } .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                Spacer()
            }
        }
        // MARK - Vendors Goods
        // Show Vendor Goods Hstack
        HStack {
            ForEach(cardManager.vendorGoods) { hero in
                Button(action: {
                    showDetailSkillView.toggle() // Button for shows brief skill
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 130)
                            .foregroundColor(.brown)
                            .cornerRadius(10)
                            .offset(x: 5)
                            .offset(y: 8)
                        Rectangle()
                            .frame(width: 100, height: 130)
                            .foregroundColor(.yellow)
                            .cornerRadius(10)
                        
                        /*
                         self.vendorGoods = [
                         Item(name: "Artifacts"),
                         Item(name: "Morningstar"),
                         Item(name: "Lucky Coin"),
                         Item(name: "Goblin Journal"),
                         Item(name: "Portion")
                         ]
                         */
                        
                        VStack() {
                            var myHero = hero.name
                            if myHero == "Artifacts" {
                                Image("knight")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == "Morningstar" {
                                Image("princess")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == "Lucky Coin" {
                                Image("priest")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == "Goblin Journal" {
                                Image("duelist")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if myHero == "Portion" {
                                Image("king")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Text(hero.name.capitalized)
                                .font(.headline)
                                .fontDesign(.monospaced)
                                .bold()
                           
                            if showDetailSkillView {
                                // heres what we gotta do makes the view clickable
                                VStack(alignment: .leading) {
                                    ForEach(hero.skills) { skill in
                                        // SKILLS CLICKABLE, UI -> skills title, Action -> SHOW POPUP
                                        Button(action: {
                                            cardManager.showMoreDetail = true
//                                            selectedHeros.append(hero)
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
        
    }
}
