//
//  AbilityDetailViewPage.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/2.
//

import Foundation
import SwiftUI

struct AbilityDetailViewPage: View {
    @Environment(\.dismiss) var dismiss // Add dismiss environment variable
    var skillName: String
    var skillType: SkillType
    @ObservedObject var cardmanager = CardManager.shared
//    @Binding var showNewViewatDetail: Bool //Usinf binding to modify state in parent view
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    VStack{
                        Text("Hello! This is a new screen.")
                            .font(.largeTitle)
                            .padding()
                        Text("\(skillName.capitalized)") // TBD: SkillName
                            .font(.largeTitle)
                            .padding()
                        Text("\(skillType)") // TBD: SkillName
                            .font(.title)
                            .padding()
                    }
                }
                Button("Dismiss") {
                    dismiss() // Call dismiss to close the sheet
                    cardmanager.showNewView = false // Correctly updates the parent state
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

