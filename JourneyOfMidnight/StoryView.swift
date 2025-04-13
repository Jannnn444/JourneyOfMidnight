//
//  StoryView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/12.
//

import SwiftUI

struct StoryView: View {
    @State private var isSecondView: Bool
    
    init(isSecondView: Bool = false) {
           self._isSecondView = State(initialValue: isSecondView)
       }
    
    var body: some View {
        VStack {
            Text("Story View")
                .font(.title)
                .fontDesign(.monospaced)
                .foregroundStyle(.black)
            
            Button("Show view") {
                isSecondView = true
                print("Button got tapped")
            }
            
            if isSecondView{
                PopupView {
                    Text("This is 2nd View")
                    Button("Close") {
                        isSecondView = false
                        print("Close view")
                    }
                }
            }
        }
    }
}
#Preview {
    GameEntryView()
}
