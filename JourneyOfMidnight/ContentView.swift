//
//  ContentView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        var cardHeight: CGFloat = 150
        var cardWidth: CGFloat = 130
        var heroCardWidth: CGFloat = 180
        var bkgWidth: CGFloat = 700
        var bkgHeight: CGFloat = 170
        Text("Journey of midnight")
        VStack {
            ZStack{
                // Background Area
                Rectangle()
                    .frame(width: bkgWidth, height: bkgHeight)
                    .cornerRadius(30)
                // Card display area
                HStack {
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: heroCardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                }
            }
            Spacer()
            ZStack {
                // Background Area
                Rectangle()
                    .frame(width: bkgWidth, height: bkgHeight)
                    .cornerRadius(30)
                // Card display area
                HStack {
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: heroCardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .foregroundColor(.cyan)
                }
            }
        }
        .padding(.horizontal) // Padding Horizontally makes up and down liitle padding
    }
}

#Preview {
    ContentView()
}
