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
    @Binding var showMoreDetailItems: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(selectedItems) { item in
                ForEach(item.item) { i in
                //move this out so it wont shows all
                PopupView{
                    VStack {
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
                       .padding(.bottom, 20)
                        
                        
                        // Close Button
                        Button(action: {
                            cardManager.showMoreDetailItems = false
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

