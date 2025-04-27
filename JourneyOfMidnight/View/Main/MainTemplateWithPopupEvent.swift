//
//  MainTemplateWithPopupEvent.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

// simplest popup view that receives content
struct MainTemplateWithPopupEvent<Content: View>: View {
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
                .foregroundColor(.gray)
                .frame(width: 250, height: 230))
    }
}

