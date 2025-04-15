//
//  SkillViewWithBlurryBkg.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/15.
//

import SwiftUI

/*
 Mission : 
 
 1. Please add the background so we know this is detail intro view
 2. Secondly, make it clickable to change show state using enum?
 3. Makes it blurry background
 
 (e.j. if there's like the fragment as destiny)
 
 */

struct DetailSkillView: View {
    @ObservedObject var cardManager = CardManager.shared
    var skill: Skill
//    @Binding var showMoreDetail: Bool //for receving commnads from outside

    var body: some View {
        VStack {
            // Button
                
                // UI
                Text("💠\(skill.name)")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .bold()
                
            }
            
            
        }
    }


