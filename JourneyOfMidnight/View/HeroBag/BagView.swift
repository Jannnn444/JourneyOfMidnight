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
        GridItem(.fixed(60), spacing: 10),
        GridItem(.fixed(60), spacing: 10),
        GridItem(.fixed(60), spacing: 10)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Here is my bag")
                .font(.title2)
                .fontDesign(.monospaced)
            
            Text("Gold: \(gold.gold.description)")
                .font(.headline)
                .fontDesign(.monospaced)
            
            // Grid container
            LazyVGrid(columns: columns, spacing: 10) {
                // Create 6 slots (2 rows x 3 columns)
                ForEach(0..<6, id: \.self) { index in
                    ZStack {
                        // Background slot
                        Rectangle()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.brown.opacity(0.3))
                            .border(.brown, width: 2)
                        
                        // Item if it exists
                        if index < itemInMyBag.count {
                            Button(action: {
                                selectedItem = itemInMyBag[index]
                            }) {
                                Image(itemInMyBag[index].name)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
            .padding()
            
            // Show selected item name
            if let selectedItem = selectedItem {
                Text("Selected: \(selectedItem.name)")
                    .font(.headline)
                    .fontDesign(.monospaced)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
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
