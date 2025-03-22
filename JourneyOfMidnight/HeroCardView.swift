//
//  HeroCardView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation
import SwiftUI

struct HeroCardView: View {
    @ObservedObject var cardManager = CardManager.shared
    var body: some View {
        Rectangle()
            .frame(width: cardManager.heroCardWidth, height: cardManager.heroCarHeight)
            .foregroundColor(.cyan)
            .cornerRadius(20)
    }
}


