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
            .font(.largeTitle)
            .fontDesign(.monospaced)
        Text("Gold: \(gold.gold.description)")
            .font(.title)
            .fontDesign(.monospaced)
       
            ForEach(itemInMyBag) { item in
                HStack {
                    Image(item.name)
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("\(item.name)")
                        .font(.headline)
                        .fontDesign(.monospaced)
                    // MARK: - TBD:
                    /*
                     Click to show name below?
                     Make a grid for bag.
                     */
                }
        }
    }
}
