//
//  AbilityView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/3/31.
//

import Foundation
import SwiftUI

struct AbilityBoxView: View {
    @ObservedObject var cardmanager = CardManager.shared
    var body: some View {
        Rectangle()
            .frame(width: cardmanager.abilityBoxWidth,height: cardmanager.abilityBoxHeight)
            .foregroundColor(.yellow)
            .cornerRadius(30)
    }
}

#Preview {
    AbilityBoxView(cardmanager: CardManager.shared)
}
