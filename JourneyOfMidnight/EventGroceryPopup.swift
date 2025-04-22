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
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
