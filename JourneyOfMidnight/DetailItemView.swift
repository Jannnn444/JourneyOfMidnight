//
//  DetailItemView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/22.
//

import Foundation
import SwiftUI

struct DetailItemView: View {
    @ObservedObject var cardManager = CardManager.shared
    var item: Item
    
    var body: some View {
        ZStack {
            Text("💠\(item.name)")
                .font(.caption2)
                .foregroundStyle(.black)
                .fontDesign(.monospaced)
                .bold()
        }
    }
}
