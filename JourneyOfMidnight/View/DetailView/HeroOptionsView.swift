//
//  HeroOptionsView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/30.
//

//
//  HeroOptionsView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/30.
//
//
//  HeroOptionsView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/30.
//

//
//  HeroOptionsView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/30.
//

import Foundation
import SwiftUI

struct HeroOptionsView: View {
    var hero: Hero
    @State var selectedItem: Item?
    @ObservedObject var cardManager = CardManager.shared
    
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8)
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            // Hero Header
            HStack(spacing: 12) {
                Image(heroImage(for: hero.heroClass.name))
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(hero.heroClass.name.rawValue.capitalized)
                            .foregroundStyle(.white)
                            .fontDesign(.monospaced)
                            .font(.headline)
                            .bold()
                        
                        Text("Lv.\(hero.heroClass.level)")
                            .foregroundStyle(.yellow)
                            .fontDesign(.monospaced)
                            .font(.subheadline)
                            .bold()
                    }
                    
                    Text("Edit your gears!")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.caption)
                }
                Spacer()
            }
            
            // Skills Section
            VStack(alignment: .leading, spacing: 2) {
                Text("Skills:")
                    .foregroundStyle(.white)
                    .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                
                ForEach(hero.skills) { skill in
                    Text("• \(skill.name): DPS-\(skill.power)")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.caption2)
                }
            }
            
            // Equipment Grid
            VStack(spacing: 4) {
                Text("Equipment:")
                    .foregroundStyle(.white)
                    .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                
                LazyVGrid(columns: columns, spacing: 6) {
                    // Create 10 slots (2 rows x 5 columns)
                    ForEach(0..<10, id: \.self) { index in
                        ZStack {
                            // Background slot
                            Rectangle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.black.opacity(0.9))
                                .border(.gray, width: 2)
                            
                            // Item if it exists
                            if index < hero.items.count {
                                Button(action: {
                                    selectedItem = hero.items[index]
                                }) {
                                    Image(hero.items[index].name)
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 6)
            }
            
            // Show selected item info
            if let selectedItem = selectedItem {
                VStack(spacing: 2) {
                    Text("Selected: \(selectedItem.name)")
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text(selectedItem.intro)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(4)
            }
        }
        .frame(maxWidth: 380, maxHeight: 230)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
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
