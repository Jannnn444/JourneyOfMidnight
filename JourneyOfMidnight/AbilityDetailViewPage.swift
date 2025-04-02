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
    
    var body: some View {
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
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

