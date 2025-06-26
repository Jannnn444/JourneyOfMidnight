//
//  PopupView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/13.
//

import SwiftUI

// simplest popup view that receives content
struct PopupView<Content: View>: View {
    // store content
    let content: Content
    var color: Color
    
    // init with content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.color = Color.black
    }
    
    var body: some View {
        VStack {
            // display content ! DYNAMIC !
            content
        }.background(
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(color)
                .frame(width: 400, height: 280))
               
    }
}
