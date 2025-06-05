//
//  SettingMainView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/5.
//

import Foundation
import SwiftUI

struct SettingMainView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
            PickerBar()
            
        }.ignoresSafeArea()
    }
}

#Preview {
    SettingMainView()
}
