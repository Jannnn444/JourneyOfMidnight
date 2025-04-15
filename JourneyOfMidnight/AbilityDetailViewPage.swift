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
    @State var isShowView: Bool = false
    @ObservedObject var cardmanager = CardManager.shared
//  @Binding var showNewViewatDetail: Bool //Use binding to modify state in parent view
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    VStack{
                        Text("\(skillName.uppercased())") 
                        // TBD: SkillName
                            .font(.title)
                            .fontDesign(.monospaced)
                            .padding()
                        Text("\(skillType.rawValue.uppercased())") 
                        // TBD: SkillName
                            .font(.title2)
                            .fontDesign(.monospaced)
                            .padding()
                        if isShowView {
                            PopupView {
                                Text("This is 2nd View")
                                Button("Close") {
                                    isShowView = false
                                    print("Close view")
                                }
                            }
                        }
                    }
                }
                Button("ShowView") {
                    isShowView = true
                }
                Button("Close the view") {
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

#Preview {
    GameEntryView()
}


