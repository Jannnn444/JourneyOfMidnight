//
//  ABILITYVIEW.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/11.
//

import SwiftUI

struct ABILITYVIEW: View {
    @ObservedObject var cardManager = CardManager.shared
    
    var body: some View {
        VStack {
            ForEach(cardManager.hero) { hero in
                Text(hero.heroClass.name.rawValue)
                Text(hero.skills[0].name)
//                ForEach(hero.skills) { skill in
//                    Text("Hey my abilities list: \(skill.name)")
//                }
                
                
            }
        }
    }
}

#Preview {
    ABILITYVIEW()
}
