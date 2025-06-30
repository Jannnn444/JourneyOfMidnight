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
    
    var body: some View {
        HStack {
            Image(heroImage(for: hero.heroClass.name))
                .resizable()
                .frame(width: 40, height: 40)
            VStack {
                HStack {
                    Text("\(hero.heroClass.name.rawValue.capitalized)")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.title)
                        .bold()
                    Text("\(hero.heroClass.level)")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.title)
                        .bold()
                }
                Text("Edit your gears! ")
                    .foregroundStyle(.white)
                    .fontDesign(.monospaced)
                    .font(.caption)
                // grid
                ForEach(hero.skills) { skill in
                    Text("\(skill.name): DPS-\(skill.power)")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.title)
                }
                ForEach(hero.items) { item in
                    Text("Items: \(item.name)")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.title)
                }
            }
        }
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

