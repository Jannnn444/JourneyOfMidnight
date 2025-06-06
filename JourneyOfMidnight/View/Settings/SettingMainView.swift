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
        ZStack {
            Color.black.opacity(0.6)
            VStack(alignment: .leading) {
                Text("Settings")
                PickerBar()
                
                HStack(alignment: .top) {
                    Text("Music Settings")
                        .font(.body)
                        .foregroundStyle(.black)
                        .fontDesign(.serif)
                    
                    Button(action: {
                        MusicManager.shared.stopBackgroundMusic()
                    }) {
//                        Image(systemName:  )
                    }
                }
                
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    SettingMainView()
}
