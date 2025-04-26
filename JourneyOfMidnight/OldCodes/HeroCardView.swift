//
//  HeroCardView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

//import Foundation
//import SwiftUI
//
//struct HeroCardView: View {
//    let hero: Hero
//    let isSelected: Bool
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text(hero.heroClass.name.rawValue)
//                .font(.headline)
//            
//            Text("Level \(hero.heroClass.level)")
//                .font(.caption)
//                .italic()
//            
//            Spacer()
//            
//            HStack {
//                Text("HP: \(hero.stats.health)")
//                Spacer()
//                Text("END: \(hero.stats.endurance)")
//            }
//            .font(.caption2)
//        }
//        .padding(10)
//        .background(
//            LinearGradient(
//                gradient: Gradient(colors: [heroColor(hero.heroClass.name).opacity(0.8), heroColor(hero.heroClass.name)]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//        )
//        .foregroundColor(.white)
//        .cornerRadius(10)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 4)
//        )
//        .scaleEffect(isSelected ? 1.05 : 1.0)
//    }
//    
//    // Get a color based on hero class
//    func heroColor(_ heroClass: HeroClassName) -> Color {
//        switch heroClass {
//        case .fighter:
//            return Color.red
//        case .wizard:
//            return Color.blue
//        case .rogue:
//            return Color.green
//        case .priest:
//            return Color.purple
//        case .duelist:
//            return Color.orange
//        case .templar:
//            return Color.yellow
//        }
//    }
//}
