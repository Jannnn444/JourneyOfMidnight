//
//  EventVendorPopup.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/22.
//

import Foundation
import SwiftUI

struct EventVendorPopup: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedItem: Item?
    @Binding var showDetailSkillView: Bool
    @Binding var showMoreDetailItems: Bool
    
    var body: some View {
        // Only show popup if there's a selected item
        if let item = selectedItem {
            PopupView {
                HStack {
                    // Debug and fix image loading
                    Image(getItemImageName(for: item.name))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding()
                        .onAppear {
                            print("Trying to load item image: \(getItemImageName(for: item.name)) for item: \(item.name)")
                        }
                    
                    VStack {
                        Text(item.name)
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontDesign(.monospaced)
                        
                        Text(item.intro)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .multilineTextAlignment(.center)
                        
                        Text(item.price.description)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .fontDesign(.monospaced)
                        
                        // NOTE:
                        /*
                         1. Set item size for later use, small 1 med 2 large 3 -- >>> Set 3 square using width for squares
                         2. Game Logic how to minus down the values
                         3. Hero Blood Bar ? Choose A to attack B
                         4. If people take you for granted and thought ur easy say no to no matter which events
                         5. gonna pewk if he keep having that weird smile face ....
                         6. hope listing can help but tbh ppl here really odd like no reason they so quiet
                         7. Items are quite need to be edi tand ideas are bad and crazy ... what a disgusting creature ever
                         */
                        
                    }
                    .padding(.bottom, 20)
                }
                
                // Close Button
                Button(action: {
                    cardManager.showMoreDetailItems = false
                    selectedItem = nil
                }) {
                    Text("Close")
                        .padding()
                        .foregroundColor(.white)
                        .fontDesign(.monospaced)
                        .bold()
                        .font(.headline)
                        .background(Color.secondary)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    // Helper function to get correct image name
    private func getItemImageName(for itemName: String) -> String {
        switch itemName.lowercased() {
        case "artifacts": return "artifact"
        case "star": return "star"
        case "lucky coin": return "coin"
        case "goblin journal": return "goblinJournal"
        case "potion": return "portion"
        case "armore": return "armore"
        case "pants": return "pants"
        case "wands": return "wands"
        case "handbook": return "handbook"
        case "cat": return "cat"
        case "staff": return "staff"
        case "holybook": return "holybook"
        case "cross": return "cross"
        case "fakeid": return "fakeID"
        case "letter": return "letter"
        default:
            print("No image mapping found for: \(itemName)")
            return "defaultItem" // Make sure you have this fallback image
        }
    }
}
