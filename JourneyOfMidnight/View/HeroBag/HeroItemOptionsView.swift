import Foundation
import SwiftUI

struct HeroItemOptionsView: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var hero: Hero
    @State var myBag: [Item] = []
    @State var mySkillBag: [Skill] = []
    
    let onClose: () -> Void
    
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8)
    ]
    
    private func saveSelections() {
    }
    
    private func initializeBags() {
        if !hero.activeSkills.isEmpty {
            
            // Set selected skills from activeSkills
            for skill in hero.activeSkills {
                if let index = hero.skills.firstIndex(where: { $0.name == skill.name }) {
              
                }
            }
        }
        

        
        print("Initialized bags - Items: \(myBag.map { $0.name }), Skills: \(mySkillBag.map { $0.name })")
    }
    
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
                            if index < $hero.inventory.count {
                                // Show item
                                Button(action: {
                               
                                    print("Hero items: \(hero.inventory[index].name)")
                                    print("Item bags: \(myBag.map { $0.name })")
                                }) {
                                    ZStack {
                                        Image(hero.inventory[index].name)
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                        
                                        // Visual indicator if item is selected
//                                        if hero.inventory[index].isChose {
//                                            Rectangle()
//                                                .stroke(.yellow, lineWidth: 3)
//                                                .frame(width: 35, height: 35)
//                                        }
                                    }
                                }
                                
                            } else if (index - hero.inventory.count) < hero.skills.count {
                                // Show skill
                                let skillIndex = index - hero.inventory.count
                                let currentSkill = hero.skills[skillIndex]
                                
                                Button(action: {
                                   
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
                           
                                    }
                                }
                            }
                        }
                    } // ForEach
                }
                .padding(.horizontal, 6)
            }
            
            // MARK: Items & Skills Display
            HStack {
                VStack(alignment: .leading) {
                    Text("Items: \(myBag.count)/2")
                        .foregroundStyle(.white)
                        .font(.caption)
                    
                    HStack(spacing: 2) {
                        ForEach(myBag, id: \.name) { item in
                            Image(item.name)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .background(Color.black.opacity(0.3))
                                .border(.yellow, width: 1)
                        }
                        
                        ForEach(0..<(2 - myBag.count), id: \.self) { _ in
                            Rectangle()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray.opacity(0.3))
                                .border(.gray, width: 1)
                        }
                    }
                    
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
                    Text("Skills: \(mySkillBag.count)/1")
                        .foregroundStyle(.white)
                        .font(.caption)
                    
                    HStack(spacing: 2) {
                        ForEach(mySkillBag, id: \.name) { skill in
                            ZStack {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.white.opacity(0.5))
                                    .overlay(Circle().stroke(.blue, lineWidth: 1))
                                
                                Image(skillImage(for: skill.name))
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            }
                        }
                        
                        // Show empty slots
                        ForEach(0..<(1 - mySkillBag.count), id: \.self) { _ in
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray.opacity(0.3))
                                .overlay(Circle().stroke(.gray))
                        }
                    }
                    
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
            
            // MARK: - Close Button
            Button(action: {
                saveSelections()
                onClose()
            }) {
                Text("Save & Close")
                    .padding(10)
                    .foregroundColor(.black)
                    .fontDesign(.monospaced)
                    .bold()
                    .font(.caption2)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: 380, maxHeight: 280)
        .padding()
        .onAppear {
            initializeBags()
        }
        .onChange(of: hero.id) { _ in
            initializeBags()
        }
        // MARK: refresh logic hererere
    }
    

   
    
    // MARK: - Helper Functions
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
        default: return "defaultSkill"
        }
    }
}
