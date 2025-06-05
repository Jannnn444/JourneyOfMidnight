//
//  EventGroceryShop.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EventVendorShop: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var IsShowDetailItemView:  Bool
    @Binding var showMoreDetail: Bool
    @Binding var selectedItems : [VendorGoods]
    
    var body: some View {
        ZStack {
        // MARK: - Banner and Event title
//            Rectangle()
//                .frame(width: 500, height: 350)
//                .foregroundColor(.indigo.opacity(0.8))
//                .cornerRadius(20)
            
//            Image("banner")
//                .frame(width: 400, height: 200)
//                .padding()
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
                }   .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                Spacer()
            }

        // MARK - Vendors Goods
        // Show Vendor Goods Hstack
        HStack {
            ForEach(cardManager.vendorGoods) { item in
                ForEach(item.item) { i in
                Button(action: {
                    IsShowDetailItemView.toggle() // Button for shows brief skill
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
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        
                        /*
                         [
                         Item(name: "Artifacts"),
                         Item(name: "Morningstar"),
                         Item(name: "Lucky Coin"),
                         Item(name: "Goblin Journal"),
                         Item(name: "Portion")
                         ]
                         */
                        
                        VStack() {
                            switch i.name {
                            case "Artifacts" :
                                Image("artifact")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            case "Morning Star":
                                Image("morningstar")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            case "Lucky Coin":
                                Image("coin")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            case "Goblin Journal":
                                Image("goblinJournal")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            case "Potion":
                                Image("portion")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            default:
                                EmptyView()
                            }
                                
                                Text(i.name.capitalized)
                                    .font(.caption)
                                    .foregroundStyle(.black)
                                    .fontDesign(.monospaced)
                                    .bold()
                                
                            if IsShowDetailItemView {
                                VStack(alignment: .leading) {
                                  Button(action: {
                                      cardManager.showMoreDetailItems = true
                                      selectedItems.append(item)   // add the whole struct
                                  }) {
                                      DetailItemView(item: i)
                                      
                                  }
                                }
                            }
                            
                            }
                        }
                    } // Zstack
                }
            } // ForEach hero
        } .position(x: 410, y: 150)
    }
    }
}
