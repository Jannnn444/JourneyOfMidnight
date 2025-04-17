//
//  ShopView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/12.
//

import Foundation
import SwiftUI

struct ShopView: View {
    @ObservedObject var cardmanager = CardManager.shared
    
    var body: some View {
        Text("Shop Frame")
            .font(.headline)
            .fontDesign(.monospaced)
        Rectangle()
            .frame(width: cardmanager.boardWidth, height: cardmanager.boardHeight)
            .foregroundStyle(.red)
        
    }
}


#Preview {
    ShopView(cardmanager: CardManager.shared)
}
