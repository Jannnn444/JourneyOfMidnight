//
//  ColorExtension.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/5.
//

import Foundation
import SwiftUI

extension Color {
    var toHex: String {
        switch self {
        case .black: return "black"
        case .red: return "red"
        case .blue: return "blue"
        case .yellow: return "yellow"
        default: return "black"
        }
    }
    
    static func fromHex(_ hex: String) -> Color {
        switch hex {
        case "red": return .red
        case "blue": return .blue
        case "yellow": return .yellow
        default: return .black
            
        }
    }
}
