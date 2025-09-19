//
//  PersonalProfileView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/18.
//

import SwiftUI

// MARK: - Fixed Profile View (Proper Safe Area Handling)
struct ProfileView: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var userService = UserServiceViewModel()
    @State private var selectedUserId = 1
    
    var body: some View {
        ZStack {
            // Background Image - Full Screen Coverage
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            // Content with proper safe area respect
            VStack {
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            // Content
                            if userService.isLoading {
                                VStack {
                                    ProgressView()
                                        .tint(.white)
                                    Text("Loading user...")
                                        .foregroundColor(.white)
                                }
                                .frame(width: geometry.size.width) // Take full screen width
                            } else if let user = userService.user {
                                
                                // Profile Picture Section - Flexible width
                                VStack(spacing: 15) {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 120, height: 120)
                                        .overlay(
                                            Image(String(user.name.prefix(1)).lowercased()+"ightling")
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                        )
                                    
                                    Text(user.name)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Text(user.email)
                                        .foregroundColor(.cyan)
                                }
                                .frame(minWidth: 200) // Minimum width, but can expand
                                
                                // Basic Info Section - Flexible width
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Personal Information")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image("star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("Username: \(user.username)")
                                        }
                                       
                                        HStack {
                                            Image("star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("Website: \(user.website)")
                                        }
                                        HStack {
                                            Image("star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("City: \(user.address.city)")
                                        }
                                        HStack {
                                            Image("star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }
                                        Text("Company: \(user.company.name)")
                                    }
                                    .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.black.opacity(0.4))
                                .cornerRadius(8)
                                .frame(minWidth: 400) // Flexible width
                                
                                // Action Section - Flexible width
                                VStack {
                                    Button(action: {
                                        cardManager.showProfile = false
                                    }) {
                                        Text("Back")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                                .frame(minWidth: 100) // Flexible width
                                
                            } else if let error = userService.errorMessage {
                                Text("Error: \(error)")
                                    .foregroundColor(.red)
                                    .padding()
                                    .frame(width: geometry.size.width) // Take full screen width
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 100)
                        .frame(minWidth: geometry.size.width) // Ensure content is at least screen width
                    }
                }
            }
            .safeAreaInset(edge: .top) { // Respect safe area at top
                Color.clear.frame(height: 0)
            }
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
}
