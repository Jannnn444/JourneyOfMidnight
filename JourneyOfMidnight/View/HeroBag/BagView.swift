//
//  BagView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/20.
//

import Foundation
import SwiftUI

struct BagView : View {
    @State var gold: Gold
    @State var itemInMyBag: [Item]
    
    var body: some View {
        Text("Here is my bag")
        Text("my gold number: \(gold)")
        ForEach(itemInMyBag) { item in
            Text("Items in bag \(item)")
        }
       
    }
}
