//
//  ButtomButton.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import SwiftUI

struct ButtomButton: View {
    @Binding var eventState: Events
    @AppStorage("selectedAppColor") private var selectedColorName = "black"
    let textOnButton: String
    
    var body: some View {

                Button(action: {
                    eventState = shuffleEvents()
                    print("\(eventState)")
                }) {
                    Text(textOnButton)
                        .padding()
                        .fontDesign(.monospaced)
                        .background(Color.fromHex(selectedColorName).opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

            }
}
