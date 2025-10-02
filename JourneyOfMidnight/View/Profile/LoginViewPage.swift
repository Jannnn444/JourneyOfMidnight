//
//  LoginView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/10/2.
//

import SwiftUI

struct LoginViewPage: View {
    @ObservedObject var cardManager = CardManager.shared
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Login View")
                    .padding()
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
                
                Button(action: {
                    cardManager.showLoginPage = false
                }) {
                    Text("Closed")
                        .padding()
                        .font(.caption)
                        .foregroundStyle(.black)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
            }
        }
    }
}
