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
    var color: Color
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: cardmanager.abilityBoxWidth,height: cardmanager.abilityBoxHeight)
                .foregroundColor(color)
                .cornerRadius(30)
//            Button(action: {
//                print("This button got pressed!")
//                showNewView = true
//            }, label: {
//                
//            })
        }
//        .sheet(isPresented: $showNewView) {
//            AbilityDetailViewPage()
//        }
    }
}
