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
    @State private var selectedItem: Item?
    
    // Define grid layout - 3 columns for horizontal grid
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Text("My bag")
                .font(.headline)
                .fontDesign(.monospaced)
                .foregroundStyle(.black)
            
            Text("Gold: \(gold.gold.description)")
                .font(.subheadline)
                .fontDesign(.monospaced)
                .foregroundStyle(.black)
            
            // Grid container
            LazyVGrid(columns: columns, spacing: 8) {
                // Create 6 slots (2 rows x 3 columns)
                ForEach(0..<6, id: \.self) { index in
                    ZStack {
                        // Background slot
                        Rectangle()
                            .frame(width: 45, height: 45)
                            .foregroundStyle(.brown.opacity(0.4))
                            .border(.brown, width: 1)
                        
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
                    .foregroundStyle(.black)
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
        }
        .frame(maxWidth: 380, maxHeight: 260)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

// Preview
struct BagView_Previews: PreviewProvider {
    static var previews: some View {
        BagView(
            gold: Gold(gold: 1500),
            itemInMyBag: [
                Item(name: "Artifacts", intro: "Power"),
                Item(name: "Morning Star", intro: "Brutal Weapon"),
                Item(name: "Lucky Coin", intro: "Savethrows +1"),
                Item(name: "Potion", intro: "Not a heal")
            ]
        )
    }
}
