//
//  UserProfileView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/9/27.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var cardManager = CardManager.shared
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.9).ignoresSafeArea()
           
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 450, height: 300)
                        .cornerRadius(20)
                        .border(Color(.blue), width: 12)
                        .cornerRadius(20)
            VStack {
                VStack(alignment: .leading) {
                    Text("Username")
                        .foregroundStyle(.blue)
                        .font(.title)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                    
                    Text("name")
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .fontDesign(.monospaced)
                    
                    HStack {
                        Text("Reputation")
                            .foregroundStyle(.blue)
                            .font(.title3)
                            .fontDesign(.monospaced)
                        
                        Image(systemName: "diamond.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.orange)
                        Image(systemName: "diamond.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.orange)
                        Image(systemName: "diamond.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.orange)
                        Image(systemName: "diamond.lefthalf.filled")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.orange)
                        Image(systemName: "diamond")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.orange)
                    }
                    Text("Journies")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .fontDesign(.monospaced)
                    
                }
                Divider()
                    .foregroundStyle(.black)
                    .bold()
                    .background(Color.white)
                    .frame(width: 300, height: 20)
                
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

#Preview {
    UserProfileView()
}
