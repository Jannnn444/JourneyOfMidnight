//
//  EventGroceryPopup.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/22.
//

import Foundation
import SwiftUI

struct EventGroceryPopup: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var selectedItems: [VendorGoods]
    @Binding var showDetailSkillView: Bool
    @Binding var showMoreDetails: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(selectedItems) { item in
                PopupView{
                    VStack {
                        ForEach(item.item) { i in
                            Text(i.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                                .fontDesign(.monospaced)
                                .foregroundStyle(.black)
                            Text(i.intro)
                                .foregroundStyle(.white)
                                .font(.headline)
                                .fontDesign(.monospaced)
                                .foregroundStyle(.black)
                        }
                        
                        // Close Button
                        Button(action: {
                            cardManager.showMoreDetail = false
                            selectedItems = []
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
    }
}

