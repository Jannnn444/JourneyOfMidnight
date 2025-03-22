//
//  FollowerCardView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation
import SwiftUI

struct FollowerCardView: View {
    @ObservedObject var cardManager = CardManager.shared
    var body: some View {
        Rectangle()
            .frame(width: cardManager.followerCardWidth, height: cardManager.followerCardHeight)
            .foregroundColor(.cyan)
            .cornerRadius(20)
    }
}
