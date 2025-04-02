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
    var mycolor: String = "yellow"
    
    var body: some View {
        ZStack{
            Button(action: {
                print("This button got pressed!")
            }, label: {
                Rectangle()
                    .frame(width: cardmanager.abilityBoxWidth,height: cardmanager.abilityBoxHeight)
                    .foregroundColor(Color(.yellow))
                    .cornerRadius(30)
            })
        }
    }
}

#Preview {
    AbilityBoxView(cardmanager: CardManager.shared)
}
