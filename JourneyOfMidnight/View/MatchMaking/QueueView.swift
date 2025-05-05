//
//  Queue.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import SwiftUI

struct QueueView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            VStack {
                Text("Finding Match...")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundColor(.white)
                    .padding()
                
                ProgressView()
                    .scaleEffect()
                    .padding()
                
                Text("Searching for other players...")
                    .fontDesign(.monospaced)
                    .foregroundColor(.white)
                    .padding()
                
               
            }
            
        }
    }
}


#Preview {
    QueueView()
}
