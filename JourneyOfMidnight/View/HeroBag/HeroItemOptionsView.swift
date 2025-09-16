import Foundation
import SwiftUI

struct HeroItemOptionsView: View {
    @ObservedObject var cardManager = CardManager.shared
    @Binding var hero: Hero
    @State var selectionBar: [any tagBagBar] = []
    private var totalBarSize: Int {
        return selectionBar.reduce(0) { total, item in
            total + item.size.rawValue
        }
    }
    @State private var showEmptyAlert = false
    
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
        hero.activeSkills = Array(selectionBar)
        
        let selectedSkills = selectionBar.compactMap { $0 as? Skill }
        let selectedItems = selectionBar.compactMap { $0 as? Item }
        
        print("Saved \(selectedSkills.count) skills to hero.activeSkills: \(selectedSkills.map { $0.name })")
        print("Skills: \(selectedSkills.map { $0.name })")
        print("Items: \(selectedItems.map { $0.name })")
    }
    
    private func initializeBags() {
        selectionBar.removeAll()
        print("Initialized bags with active skills: \(selectionBar.map { $0.name })")
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
                            // Background Empty Slot
                            Rectangle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.black.opacity(0.9))
                                .border(.gray, width: 2)
                            
                            // MARK: Item
                            if index < $hero.inventory.count {
                                let currentItem = hero.inventory[index]
                                let canAdd = canAddItem(currentItem)
                                let isSelected = isItemSelected(currentItem)
                                
                                Button(action: {
                                    addItemToSelection(currentItem)
                                }) {
                                    ZStack {
                                        Image(hero.inventory[index].name)
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .opacity(isSelected ? 0.5 : (canAdd ? 1.0 : 0.3))
                                        
                                        if isSelected {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.green)
                                                .background(Color.white, in: Circle())
                                        }
                                    }
                                }.disabled(!canAdd) // Disabled if cant add either selected or would exceed limit
                                
                            } else if (index - hero.inventory.count) < hero.skills.count {
                               // MARK: Skill
                                let skillIndex = index - hero.inventory.count
                                let currentSkill = hero.skills[skillIndex]
                                let canAdd = canAddItem(currentSkill)
                                let isSelected = isItemSelected(currentSkill)
                                
                                Button(action: {
                                    addItemToSelection(currentSkill)
                                }) {
                                    ZStack {
                                        // Skill background with different color
                                        Circle()
                                            .fill(Color.white.opacity(0.5))
                                            .frame(width: 35, height: 35)
                                        
                                        Image("\(skillImage(for: currentSkill.name))")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        if isSelected {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.green)
                                                .background(Color.white, in: Circle())
                                                .scaleEffect(0.8)
                                        }
                                    }
                                } .disabled(!canAdd) //Disable if can't add
                            }
                        }
                    }
                }
                .padding(.horizontal, 6)
            }
            
            // MARK: Items & Skills Bar
            HStack {
                VStack() {
                    HStack(spacing: 2) {
                        
                        // Beside the grid shows: Capacity indicator
                        /*
                        HStack {
                            Text("Capacity: \(totalBarSize)/\(hero.heroLoad.rawValue)")
                                .foregroundStyle(totalBarSize >= hero.heroLoad.rawValue ? .red : .white)
                                .fontDesign(.monospaced)
                                .font(.caption)
                                .bold()
                        }
                        .padding(.horizontal, 6) */
                        
                        ForEach(selectionBar, id: \.name) { item in
                            Button(action: {
                                // Remove item from myBag when tapped
                                if let index = selectionBar.firstIndex(where: { $0.name == item.name }) {
                                    selectionBar.remove(at: index)
                                    print("Removed \(item.name) from bag")
                                    print("myBag now: \(selectionBar.map { $0.name })")
                                }
                            }) {
                                ZStack(alignment: .center) {
                                    
                                    Rectangle()
                                        .frame(width: itemSizesToWidth(itemSize: item.size), height: cardManager.abilityBoxHeight)
                                        .foregroundStyle(.black.opacity(0.3))
                                        .cornerRadius(12)
                                        .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.yellow, lineWidth: 3)
                                        )
                                    
                                    Image(item.name)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                    
                                }
                            }
                        } //loop
                        
                    }
                    // Progress bar
                    ProgressView(value: Double(totalBarSize), total: Double(hero.heroLoad.rawValue))
                        .frame(width: 100)
                        .tint(totalBarSize >= hero.heroLoad.rawValue ? .red : .yellow)
                }
            }
            
            .padding(.horizontal) 
            
            if selectionBar.isEmpty {
                Text("Select items or skills to activate")
                    .foregroundStyle(.orange)
                    .font(.caption)
                    .italic()
            }
            
            // MARK: - Close Button
            Button(action: {
                if selectionBar.isEmpty {
                    showEmptyAlert = true
                } else {
                    saveSelections()
                    onClose()
                }
                
            }) {
                Text("Save & Close")
                    .padding(10)
                    .foregroundColor(.black)
                    .fontDesign(.monospaced)
                    .bold()
                    .font(.caption2)
                    .background(selectionBar.isEmpty ? Color.gray.opacity(0.5) : Color.gray)
                    .cornerRadius(10)
            }
            .alert("EmptySelection", isPresented: $showEmptyAlert) {
                Button("Ok") {}
            } message: {
                Text("Please select at least one item or skill before saving.")
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
    
    private func itemSizesToWidth(itemSize: itemSizes) -> CGFloat {
        var result: CGFloat = 0
        if itemSize == .small {
            result = 1 * cardManager.abilityBoxWidth
        } else if itemSize == .medium {
            result =  2 * cardManager.abilityBoxWidth
        } else if itemSize == .large {
            result =  4 * cardManager.abilityBoxWidth
        }
        return result
    }
    
    private func canAddItem(_ item: any tagBagBar) -> Bool {
        let itemSize = item.size.rawValue
        let maxLoad = hero.heroLoad.rawValue
        let wouldExceedLimit = totalBarSize + itemSize > maxLoad
        let isAlreadySelected = isItemSelected(item)
        
        return !wouldExceedLimit && !isAlreadySelected
    }
    
    private func addItemToSelection(_ item: any tagBagBar) {
        guard canAddItem(item) else {
            if isItemSelected(item) {
                print("itme \(item.name) is already selected")
            } else {
                print("Cannot add \(item.name) - would exceed size limit (current: \(totalBarSize), item: \(item.size.rawValue)")
            }
            return
        }
        selectionBar.append(item)
        print("Added \(item.name) (size: \(item.size.rawValue))")
        print("Total bag size: \(totalBarSize)/\(hero.heroLoad.rawValue)")
        print("Selection bar now: \(selectionBar.map { $0.name })")
    }
    
    private func isItemSelected(_ item: any tagBagBar) -> Bool {
        return selectionBar.contains { $0.name == item.name}
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
