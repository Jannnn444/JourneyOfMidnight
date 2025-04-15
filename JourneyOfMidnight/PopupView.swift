//
//  PopupView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/13.
//

import Foundation

import SwiftUI

// simplest popup view that receives content
struct PopupView<Content: View>: View {
    // store content
    let content: Content
    
    // init with content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            // display content ! DYNAMIC !
            content
        }.background(
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(.secondary)
                .frame(width: 100, height: 130))
    
    }
}

// Example usage
struct ContentExample: View {
    var body: some View {
        PopupView {
            // everything here becomes content
            Text("Hello")
            Button("OK") {
                print("Button tapped")
            }
        }
    }
}

struct ContentExample_Previews: PreviewProvider {
    static var previews: some View {
        ContentExample()
    }
}
