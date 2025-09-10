import Foundation
import SwiftUI

struct HeroItemOptionsView: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var hero: Hero
    @State var myBag: [any tagBag] = []
    
    let onClose: () -> Void
    
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8)
    ]
    
    private func saveSelections() {
        
        // Save all selected items and skills directly to activeSkills
            hero.activeSkills = Array(myBag)
        
            let selectedSkills = myBag.compactMap { $0 as? Skill }
            let selectedItems = myBag.compactMap { $0 as? Item }
           
//            Update hero's active skills
//            hero.activeSkills = selectedSkills
             
            print("Saved \(selectedSkills.count) skills to hero.activeSkills: \(selectedSkills.map { $0.name })")
            print("Skills: \(selectedSkills.map { $0.name })")
            print("Items: \(selectedItems.map { $0.name })")
    }
    
    private func initializeBags() {
        // Clear the bag first
        myBag.removeAll()
        
        // Add hero's active skills to myBag
//        myBag.append(contentsOf: hero.activeSkills)
        
        print("Initialized bags with active skills: \(myBag.map { $0.name })")
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
//                                   was toggleItem(at: index)
                                    // here add into the active Bag
                                    // for each item ---> should be clicked the icon and add into the array?
                                    if myBag.count < 5 {
                                        myBag.append(hero.inventory[index])
                                    } else if myBag.count == 5 {
                                            print("Bag is full now, declined add request")
                                        }
                                    print("Hero items: \(hero.inventory[index].name)")
                                    print("Item myBag now: \(myBag.map { $0.name })")
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
//                                  was  toggleSkill(at: skillIndex)
                                    // here add skills into bag
                                    
                                    if myBag.count < 5 {
                                        myBag.append(hero.skills[skillIndex])
                                    } else if myBag.count == 5 {
                                            print("Bag is full now, declined add request")
                                        }
                                    print("Hero skill: \(currentSkill.name)")
                                    print("Skill in myBag now: \(myBag.map { $0.name })")
                                    
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
            
            // MARK: Items & Skills Bar
            HStack {
                VStack() {
                    Text("Items and Skills: \(myBag.count)")
                        .foregroundStyle(.white)
                        .font(.body)
                    
                    HStack(spacing: 2) {
                        ForEach(myBag, id: \.name) { item in
                            Button(action: {
                                // Remove item from myBag when tapped
                                if let index = myBag.firstIndex(where: { $0.name == item.name }) {
                                    myBag.remove(at: index)
                                    print("Removed \(item.name) from bag")
                                    print("myBag now: \(myBag.map { $0.name })")
                                }
                            }) {
                                Image(item.name)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .background(Color.black.opacity(0.3))
                                    .border(.yellow, width: 1)
                            }
                        }
                    }
                    
                }
                    if myBag.count >= 5 {
                        Text("Item bag is full! Cannot add more items.")
                            .foregroundStyle(.red)
                            .bold()
                            .font(.caption)
                            .italic()
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
