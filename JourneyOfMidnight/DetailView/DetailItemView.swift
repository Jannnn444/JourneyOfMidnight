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
            VStack {
                Text("💠\(item.intro)")
                    .font(.caption2)
                    .foregroundStyle(.black)
                    .fontDesign(.monospaced)
                    .bold()
                    .padding(.bottom, 5)
                
                Button(action: {
                    // Purchase Logic TBD
                }) {
                    Text("Purchase")
                        .font(.caption)
                        .foregroundStyle(.black)
                        .fontDesign(.monospaced)
                        .bold()
                       
                }   .padding(5)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
            }
        }
    }
}
