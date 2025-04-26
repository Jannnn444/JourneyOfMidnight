//
//  GoldView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/23.
//

import SwiftUI

struct GoldView: View {
    @Binding var gold: Gold
    var body: some View {
        VStack {
            HStack {
                Spacer() //push to right
                Text("Gold: \(gold.gold)")
                    .padding()
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
            }
            Spacer() // push to top!
        }
    }
}

