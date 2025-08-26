import Foundation
import SwiftUI

struct HeroOptionsView: View {
    @Binding var hero: Hero
    @State var selectedItem: Item?
    @State var selectedSkill: Skill?
    @ObservedObject var cardManager = CardManager.shared
    
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8)
    ]
    @State var myBag: [Item] = []
    @State var mySkillBag: [Skill] = [] // Separate bag for skills if needed
    
    var body: some View {
        VStack(spacing: 8) {
            // Hero Header
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 70, height: 70)
                    Image(heroImage(for: hero.heroClass.name))
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(hero.heroClass.name.rawValue.capitalized)
                            .foregroundStyle(.white)
                            .fontDesign(.monospaced)
                            .font(.headline)
                            .bold()
                        
                        Text("Lv.\(hero.heroClass.level)")
                            .foregroundStyle(.yellow)
                            .fontDesign(.monospaced)
                            .font(.subheadline)
                            .bold()
                    }
                    
                    Text("Edit your gears & abilities!")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .font(.caption)
                }
                Spacer()
            }
            
            // Combined Equipment & Skills Grid
            VStack(spacing: 4) {
                Text("Equipment & Abilities:")
                    .foregroundStyle(.white)
                    .fontDesign(.monospaced)
                    .font(.caption)
                    .bold()
                
                LazyVGrid(columns: columns, spacing: 6) {
                    // Create 10 slots (2 rows x 5 columns)
                    ForEach(0..<10, id: \.self) { index in
                        ZStack {
                            // Background slot
                            Rectangle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.black.opacity(0.9))
                                .border(.gray, width: 2)
                            
                            // Items first, then skills
                            if index < hero.items.count {
                                // Show item - FIXED: Use correct index
                                Button(action: {
                                    selectedItem = hero.items[index]
                                    selectedSkill = nil // Clear skill selection
                                    toggleItem(at: index)
                                    print("Hero items: \(hero.items[index].name)")
                                    print("Item bags: \(myBag.map { $0.name })")
                                }) {
                                    ZStack {
                                        Image(hero.items[index].name)
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                        
                                        // Visual indicator if item is selected
                                        if hero.items[index].isChose {
                                            Rectangle()
                                                .stroke(.yellow, lineWidth: 3)
                                                .frame(width: 35, height: 35)
                                        }
                                    }
                                }
                                
                            } else if (index - hero.items.count) < hero.skills.count {
                                // Show skill - FIXED: Use skillIndex, not grid index
                                let skillIndex = index - hero.items.count
                                let currentSkill = hero.skills[skillIndex]
                                
                                Button(action: {
                                    selectedSkill = currentSkill
                                    selectedItem = nil // Clear item selection
                                    // FIXED: Use skill-specific toggle if needed
                                    toggleSkill(at: skillIndex)
                                    print("Selected skill: \(currentSkill.name)")
                                    print("Skill bags: \(mySkillBag.map { $0.name })")
                                }) {
                                    ZStack {
                                        // Skill background with different color
                                        Circle()
                                            .fill(Color.white.opacity(0.5))
                                            .frame(width: 35, height: 35)
                                        
                                        Image("\(skillImage(for: currentSkill.name))")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        
                                        // Visual indicator if skill is selected
                                        if currentSkill.isSelected {
                                            Circle()
                                                .stroke(.blue, lineWidth: 3)
                                                .frame(width: 35, height: 35)
                                        }
                                    }
                                }
                            }
                        }
                    } // ForEach
                }
                .padding(.horizontal, 6)
            }
            
            // Optional: Display current bags
            HStack {
                VStack(alignment: .leading) {
                    Text("Items: \(myBag.count)/3")
                        .foregroundStyle(.white)
                        .font(.caption)
                    
                    if myBag.count >= 2 {
                        Text("Item bag is full! Cannot add more items.")
                            .foregroundStyle(.red)
                            .bold()
                            .font(.caption)
                            .italic()
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Skills: \(mySkillBag.count)/3")
                        .foregroundStyle(.white)
                        .font(.caption)
                    
                    if mySkillBag.count >= 1 {
                        Text("Skill is full!")
                            .foregroundStyle(.red)
                            .bold()
                            .font(.caption)
                            .italic()
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: 380, maxHeight: 280)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
    
    // FIXED: Move function inside struct and simplify parameters
    private func toggleItem(at index: Int) {
        hero.items[index].isChose.toggle()
        
        if hero.items[index].isChose {
            // Item was just selected - try to add to bag
            if myBag.count < 2 {
                myBag.append(hero.items[index])
            } else {
                // Bag is full - revert the selection
                hero.items[index].isChose = false
                print("Item bag is full! Cannot add more items.")
            }
        } else {
            // Item was just deselected - remove from bag
            myBag.removeAll { $0.name == hero.items[index].name }
        }
    }
    
    // FIXED: Add separate function for skills
    private func toggleSkill(at index: Int) {
        hero.skills[index].isSelected.toggle()
        
        if hero.skills[index].isSelected {
            // Skill was just selected - try to add to bag
            if mySkillBag.count < 1 {
                mySkillBag.append(hero.skills[index])
            } else {
                // Bag is full - revert the selection
                hero.skills[index].isSelected = false
                print("Skill bag is full! Cannot add more skills.")
            }
        } else {
            // Skill was just deselected - remove from bag
            mySkillBag.removeAll { $0.name == hero.skills[index].name }
        }
    }
    
    private func heroImage(for heroClass: HeroClassName) -> String {
        switch heroClass {
           case .fighter: return "knight"
           case .wizard: return "princess"
           case .priest: return "priest"
           case .duelist: return "duelist"
           case .rogue: return "king"
           case .templar: return "templar"
       }
    }
    
    private func skillImage(for skillName: String) -> String {
        switch skillName.lowercased() {
            case "meteor": return "Meteor"
            case "dodge": return "dodge"
            case "rainy": return "Rainy"
            case "wolve": return "Meow"
            case "flower": return "Flower"
            case "wolvecry": return "WolveCry"
            case "moon": return "Moon"
            case "meow": return "meow"
            case "lightling": return "lightling"
            case "holy": return "Holy"
            case "god": return "god"
            case "gun": return "gun"
            case "fist": return "fist"
            default: return "defaultSkill" // fallback image
        }
    }
}
