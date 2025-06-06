//
//  PickerBar.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/5.
//

import Foundation
import SwiftUI

struct PickerBar: View {
    let colors: [Color] = [.black, .red, .blue, .yellow]
    @AppStorage("selectedAppColor") private var storedColor = "black"
    
    var body: some View {
  
            Form {
                Picker("Selected your colors", selection: Binding(
                    get: { Color.fromHex(storedColor) },
                    set: { newColor in storedColor = newColor.toHex }
                )) {
                    ForEach(colors, id: \.self) { color in
                        Text(color.description.capitalized)
                            .tag(color)
                    }
                }
            
        }
    }
}
#Preview {
   PickerBar()
}
