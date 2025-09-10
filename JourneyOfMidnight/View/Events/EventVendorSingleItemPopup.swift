//
//  EventVendorSingleItemPopup.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/11.
//

import Foundation
import SwiftUI

struct EventVendorSingleItemPopup: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedItem: Item?
    @Binding var showDetailSkillView: Bool
    @Binding var showMoreDetailItems: Bool
    
    var body: some View {
        if let item = selectedItem {
            PopupView {
                VStack {
                    Text(item.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontDesign(.monospaced)
                    Text(item.intro)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontDesign(.monospaced)
                }
                .padding(.bottom, 20)
                
                // Close Button
                Button(action: {
                    cardManager.showMoreDetailItems = false
                    selectedItem = nil
                }) {
                    Text("Close")
                        .padding()
                        .foregroundColor(.black)
                        .fontDesign(.monospaced)
                        .bold()
                        .font(.headline)
                        .background(Color.secondary)
                        .cornerRadius(10)
                }
            }
        }
    }
}


