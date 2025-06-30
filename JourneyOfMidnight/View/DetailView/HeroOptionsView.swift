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
        Image(heroImage(for: hero.heroClass.name))
            .resizable()
            .frame(width: 40, height: 40)
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
