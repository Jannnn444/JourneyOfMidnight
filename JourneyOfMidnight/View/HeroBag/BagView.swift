//
//  BagView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/20.
//

import Foundation
import SwiftUI

struct BagView: View {
    @State var gold: Gold
    @State var itemInMyBag: [Item]
    @State var selectedItem: Item?
    @ObservedObject var cardManager = CardManager.shared
    @State var selectedHeroBag: [Item]
    @State private var showActionMenu = false
    @State private var actionMenuItemIndex: Int?
    
    // Define grid layout - 3 columns for horizontal grid
    let columns = [
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
        GridItem(.fixed(45), spacing: 8),
    ]
    
    var body: some View {
        ZStack { // ✅ FIXED: Wrap entire body in ZStack
            VStack(spacing: 12) {
                Text("My bag")
                    .font(.headline)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                
                Text("Gold: \(gold.gold.description)")
                    .font(.subheadline)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                
                // Grid container
                LazyVGrid(columns: columns, spacing: 8) {
                    // Create 10 slots (2 rows x 5 columns)
                    ForEach(0..<10, id: \.self) { index in
                        ZStack {
                            // Background slot
                            Rectangle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.black.opacity(0.9))
                                .border(.gray, width: 2)
                            
                            // Item if it exists
                            if index < itemInMyBag.count {
                                // ✅ FIXED: Remove nested Button - only one Button needed
                                Button(action: {
                                    selectedItem = itemInMyBag[index]
                                    actionMenuItemIndex = index
                                    showActionMenu = true
                                    print("Item clicked: \(itemInMyBag[index].name)") // Debug
                                }) {
                                    Image(itemInMyBag[index].name)
                                        .resizable()
                                        .frame(width: 38, height: 38)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
                
                // Show selected item name
                if let selectedItem = selectedItem, !showActionMenu {
                    Text("Selected: \(selectedItem.name)")
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(6)
                } else {
                    // Placeholder to maintain layout
                    Text(" ")
                        .font(.caption)
                        .padding(.vertical, 4)
                }
                
                HStack {
                    ForEach(cardManager.myHeroCards) { hero in
                        HStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(heroImage(for: hero.heroClass.name))
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                )
                                .overlay(
                                    Text("\(hero.heroClass.level)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(4)
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                        .offset(x:20, y:-20)
                                )
                            // when click on the icon, bag shows hero.bag ....
                        }
                    }
                }
            }
            .frame(maxWidth: 380, maxHeight: 260)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            
            // ✅ FIXED: Popup is now inside the main ZStack
            if showActionMenu, let selectedItem = selectedItem {
                // Background overlay to dismiss popup
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismissActionMenu()
                    }
                
                // Action menu
                VStack(spacing: 0) {
                    // Header with item name
                    HStack {
                        Text(selectedItem.name.capitalized)
                            .font(.caption)
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                        Spacer()
                        Button("✕") {
                            dismissActionMenu()
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    
                    Divider()
                    
                    // Action buttons
                    actionButton("⭐ Add to Favorites") {
                        addToFavorites(item: selectedItem)
                    }
                    
                    Divider()
                    
                    // Dynamic hero list
                    ForEach(cardManager.myHeroCards, id: \.id) { hero in
                        actionButton("👤 Add to \(hero.heroClass.name.rawValue.capitalized)") {
                            addToHero(item: selectedItem, hero: hero)
                        }
                        if hero.id != cardManager.myHeroCards.last?.id {
                            Divider()
                        }
                    }
                    
                    Divider()
                    
                    actionButton("📖 Read Intro") {
                        readIntro(item: selectedItem)
                    }
                    
                    Divider()
                    
                    actionButton("🗑️ Drop Item") {
                        dropItem(item: selectedItem, at: actionMenuItemIndex ?? 0)
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(30)
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showActionMenu)
            }
        } // ✅ FIXED: ZStack closing brace
    }
    
    // MARK: - Action Button Helper
    private func actionButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
            dismissActionMenu()
        }) {
            HStack {
                Text(title)
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
        }
        .background(Color.white)
        .contentShape(Rectangle()) // Makes entire area tappable
    }
    
    // MARK: - Helper Functions
    private func dismissActionMenu() {
        showActionMenu = false
        actionMenuItemIndex = nil
        print("Action menu dismissed") // Debug
    }
    
    // MARK: - Action Functions
    private func addToFavorites(item: Item) {
        print("Added \(item.name) to favorites")
        // TODO: Implement favorites functionality
    }
    
    private func addToHero(item: Item, hero: Hero) {
        print("Added \(item.name) to \(hero.heroClass.name.rawValue)")
        // TODO: Add item to hero's inventory
    }
    
    private func readIntro(item: Item) {
        print("Reading intro for \(item.name): \(item.intro)")
        // TODO: Show item intro in a separate popup or detail view
    }
    
    private func dropItem(item: Item, at index: Int) {
        print("Dropped \(item.name)")
        removeItemFromBag(at: index)
    }
    
    private func removeItemFromBag(at index: Int) {
        if index < itemInMyBag.count {
            itemInMyBag.remove(at: index)
            selectedItem = nil
        }
    }
}

// MARK: - Helper Function (keep outside the struct)
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
