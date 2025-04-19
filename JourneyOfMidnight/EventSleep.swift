//
//  EventSleep.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/19.
//

import Foundation
import SwiftUI

struct EventSleep: View {
    var body: some View {
        Rectangle()
            .frame(width: 500, height: 350)
            .foregroundColor(.pink.opacity(0.8))
            .cornerRadius(20)
        Image("banner")
            .frame(width: 400, height: 200)
            .padding()
        VStack {
            HStack {
                Image("campfire")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Rest Recharge")
                    .font(.title)
                    .bold()
                    .fontDesign(.monospaced)
                    .foregroundStyle(.black)
            } .padding()
                .background(Color.white)
                .cornerRadius(10)
            Spacer()
        }
    }
}
