//
//  HeroSelectionView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/18.
//

/*
 
This is for testing page
 
import Foundation
import SwiftUI

struct HeroSelectionView: View {
    @StateObject private var cardManager = CardManager.shared
    @State private var selectedHeroes: [Hero] = []
    @State private var hoveredHero: Hero? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hero Selection")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Heroes Display
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: cardManager.heroCardWidth))], spacing: 16) {
                        ForEach(cardManager.hero) { hero in
                            HeroCardView(hero: hero, isSelected: selectedHeroes.contains(hero))
                                .frame(width: cardManager.heroCardWidth, height: cardManager.heroCarHeight)
                                .scaleEffect(hoveredHero?.id == hero.id ? 1.1 : 1.0)
                                .animation(.spring(), value: hoveredHero?.id == hero.id)
                                .onTapGesture {
                                    toggleHeroSelection(hero)
                                }
                                // Add hover effect (works on macOS)
                                .onHover { isHovering in
                                    if isHovering {
                                        hoveredHero = hero
                                        cardManager.showMoreDetail = true
                                    } else {
                                        if hoveredHero?.id == hero.id {
                                            hoveredHero = nil
                                            cardManager.showMoreDetail = false
                                        }
                                    }
                                }
                                // Keep long press for iOS
                                .onLongPressGesture(minimumDuration: 0.1) {
                                    // On long press, show detail
                                    hoveredHero = hero
                                    cardManager.showMoreDetail = true
                                } onPressingChanged: { isPressing in
                                    // When finger lifts, hide detail
                                    if !isPressing && hoveredHero?.id == hero.id {
                                        withAnimation(.easeOut(duration: 0.2)) {
                                            hoveredHero = nil
                                            cardManager.showMoreDetail = false
                                        }
                                    }
                                }
                        }
                    }
                    .padding()
                }
                
                // Detail Panel when hero is hovered/long-pressed
                if let hero = hoveredHero, cardManager.showMoreDetail {
                    HeroDetailView(hero: hero)
                        .frame(width: 250)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(), value: cardManager.showMoreDetail)
                }
            }
            
            // Selected Heroes Display
            VStack(alignment: .leading, spacing: 10) {
                Text("Selected Heroes (\(selectedHeroes.count))")
                    .font(.title2)
                    .fontWeight(.bold)
                
                if selectedHeroes.isEmpty {
                    Text("No heroes selected yet.")
                        .foregroundColor(.gray)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(selectedHeroes) { hero in
                                Text(hero.heroClass.name.rawValue)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Toggle hero selection
    func toggleHeroSelection(_ hero: Hero) {
        if selectedHeroes.contains(hero) {
            selectedHeroes.removeAll(where: { $0.id == hero.id })
        } else {
            selectedHeroes.append(hero)
        }
    }
}
*/
