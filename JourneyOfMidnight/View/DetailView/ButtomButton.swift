//
//  ButtomButton.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import SwiftUI

struct ButtomButton: View {
    @Binding var eventState: Events
    let textOnButton: String
    
    var body: some View {
        VStack {
            Spacer() // push to the buttom
            HStack {
                Spacer()  // push to right
                Button(action: {
                    eventState = shuffleEvents()
                }) {
                    Text(textOnButton)
                        .padding()
                        .fontDesign(.monospaced)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}
