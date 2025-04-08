//
//  StoryView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/7.
//

import Foundation
import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Story View")
                .font(.title)
                .foregroundStyle(.black)
                .fontDesign(.monospaced)
            HStack(alignment: .top) {
            Button(action: {
                dismiss()
            }) {
                Text("Exit")
                    .frame(width: 40, height: 10)
                    .padding()
                    .font(.footnote)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            }
        }
    }
}
