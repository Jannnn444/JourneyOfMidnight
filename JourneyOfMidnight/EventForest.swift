//
//  EventForest.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EventForest: View {
    var body: some View {
        Rectangle()
            .frame(width: 500, height: 350)
            .foregroundColor(.green.opacity(0.8))
            .cornerRadius(20)
        Image("banner")
            .frame(width: 400, height: 200)
            .padding()
        VStack {
            HStack {
                Image("forest")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Adventure Forest")
                    .font(.title)
                    .bold()
                    .fontDesign(.monospaced)
                    .foregroundStyle(.black)
            } .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
            Spacer()
        }
    }
}
