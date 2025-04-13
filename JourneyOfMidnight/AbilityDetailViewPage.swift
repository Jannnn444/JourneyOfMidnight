//
//  AbilityDetailViewPage.swift
//  JourneyOfMidnight
//
//  Created by yucian huang on 2025/4/2.
//

import SwiftUI

struct AbilityDetailViewPage: View {
    var skillName: String
    var skillType: SkillType
    @ObservedObject var cardmanager = GameCardManager.shared
//  @Binding var showNewViewatDetail: Bool //Use binding to modify state in parent view
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    VStack{
                        Text("\(skillName.uppercased())") // TBD: SkillName
                            .font(.title)
                            .fontDesign(.monospaced)
                            .padding()
                        Text("\(skillType.rawValue.uppercased())") // TBD: SkillName
                            .font(.title2)
                            .fontDesign(.monospaced)
                            .padding()
                    }
                }
                Button("Close") {
                    cardmanager.showAbilityDetailView = false
                }
                .padding()
                .background(Color.secondary)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}
