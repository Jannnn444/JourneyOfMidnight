//
//  StoryView.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/7.
//

import Foundation
import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var cardManager = CardManager.shared
    var heroContent: [Hero]?
    
    var body: some View {
        VStack {
            Text("Story View")
                .font(.title)
                .foregroundStyle(.black)
                .fontDesign(.monospaced)
            
            if let heroContent = heroContent {
                ForEach(heroContent) { hero in
                    Text("\(hero.heroClass.name)")
                    Text("Attributes- charisma\(hero.attributes.Charisma)")
                }
            }
            
            HStack(alignment: .top) {
                Button(action: {
                    dismiss()
                }) {
                    Text("Leave")
                        .frame(width: 40, height: 10)
                        .padding()
                        .font(.footnote)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
                Button(action: {
                    
                }) {
                    Text("Yes, take the challenge")
                        .frame(width: 150, height: 20)
                        .padding()
                        .font(.footnote)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                Button(action: {
                    
                }) {
                    Text("No, no chance")
                        .frame(width: 150, height: 20)
                        .padding()
                        .font(.caption)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
        }
    }
}
