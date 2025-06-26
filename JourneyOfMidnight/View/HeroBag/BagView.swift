//
//  BagView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/20.
//

import Foundation
import SwiftUI

struct BagView: View {
    @State var gold: Gold
    @State var itemInMyBag: [Item]
    @State var selectedItem: Item?
    @ObservedObject var cardManager = CardManager.shared
    @State var selectedHeroBag: [Item]
    
    // Define grid layout - 3 columns for horizontal grid
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Text("My bag")
                .font(.headline)
                .fontDesign(.monospaced)
                .foregroundStyle(.white)
            
            Text("Gold: \(gold.gold.description)")
                .font(.subheadline)
                .fontDesign(.monospaced)
                .foregroundStyle(.white)
            
            // Grid container
            LazyVGrid(columns: columns, spacing: 8) {
                // Create 6 slots (2 rows x 3 columns)
                ForEach(0..<10, id: \.self) { index in
                    ZStack {
                        // Background slot
                        Rectangle()
                            .frame(width: 45, height: 45)
                            .foregroundStyle(.black.opacity(0.9))
                            .border(.gray, width: 2)
                        
                        // Item if it exists
                        if index < itemInMyBag.count {
                            Button(action: {
                                selectedItem = itemInMyBag[index]
                            }) {
                                Image(itemInMyBag[index].name)
                                    .resizable()
                                    .frame(width: 38, height: 38)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            
            // Show selected item name
            if let selectedItem = selectedItem {
                Text("Selected: \(selectedItem.name)")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(6)
            } else {
                // Placeholder to maintain layout
                Text(" ")
                    .font(.caption)
                    .padding(.vertical, 4)
            }
            HStack {
                ForEach(cardManager.myHeroCards) { hero in
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(heroImage(for: hero.heroClass.name))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            )
                            .overlay(
                                Text("\(hero.heroClass.level)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding(4)
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                                    .offset(x:20, y:-20)
                            )
                    }
                }
            }
        }
        .frame(maxWidth: 380, maxHeight: 260)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

private func heroImage(for heroClass: HeroClassName) -> String {
    switch heroClass {
       case .fighter: return "knight"
       case .wizard: return "princess"
       case .priest: return "priest"
       case .duelist: return "duelist"
       case .rogue: return "king"
       case .templar: return "templar"
       }
   }

