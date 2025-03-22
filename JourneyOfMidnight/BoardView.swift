//
//  BoardVIew.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import Foundation
import SwiftUI

struct BoardView: View {
    @ObservedObject var cardManager = CardManager.shared
    var body: some View {
        Rectangle()
            .frame(width: cardManager.boardWidth, height: cardManager.boardHeight)
            .cornerRadius(30)
            .cornerRadius(20)
    }
}
