//
//  EventGame.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EventCombat: View {
    var body: some View {
        Rectangle()
            .frame(width: 500, height: 350)
            .foregroundColor(.blue.opacity(0.8))
            .cornerRadius(20)
        Image("banner")
            .frame(width: 400, height: 200)
            .padding()
        
        VStack {
            HStack {
                Image("fight")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Battle For Glory")
                    .font(.title)
                    .bold()
                    .fontDesign(.monospaced)
                    .foregroundStyle(.black)
            } .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
            Spacer()
        }
    }
}
