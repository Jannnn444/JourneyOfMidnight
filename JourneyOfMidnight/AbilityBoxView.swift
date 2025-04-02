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
    @State private var showNewView = false
    
    var body: some View {
        ZStack{
            Button(action: {
                print("This button got pressed!")
                showNewView = true
            }, label: {
                Rectangle()
                    .frame(width: cardmanager.abilityBoxWidth,height: cardmanager.abilityBoxHeight)
                    .foregroundColor(color)
                    .cornerRadius(30)
            })
        }
        .sheet(isPresented: $showNewView) {
            NewView()
        }
    }
}

struct NewView: View {
    var body: some View {
        VStack {
            Text("Hello! This is a new screen.")
                .font(.largeTitle)
                .padding()
            Button("Dismiss") {
                // Here will be handle automatically
            }
        }
    }
}






