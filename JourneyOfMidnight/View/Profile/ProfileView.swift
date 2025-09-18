//
//  PersonalProfileView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/18.
//

import SwiftUI

// MARK: - Horizontal Profile View
struct ProfileView: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var userService = UserServiceViewModel()
    @State private var selectedUserId = 1
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) { // Enable horizontal scrolling
                HStack(spacing: 30) { // Changed from VStack to HStack
                    
                    // Content
                    if userService.isLoading {
                        VStack {
                            ProgressView()
                            Text("Loading user...")
                                .foregroundColor(.secondary)
                        }
                    } else if let user = userService.user {
                        
                        // Profile Picture Section
                        VStack(spacing: 15) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 120, height: 120) // Larger for horizontal layout
                                .overlay(
                                    Text(String(user.name.prefix(1)))
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                )
                            
                            Text(user.name)
                                .font(.title2)
                                .bold()
                            
                            Text(user.email)
                                .foregroundColor(.blue)
                        }
                        .frame(width: 200) // Fixed width for consistency
                        
                        // Basic Info Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Personal Information")
                                .font(.headline)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username: \(user.username)")
                                Text("Website: \(user.website)")
                                Text("City: \(user.address.city)")
                                Text("Company: \(user.company.name)")
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .frame(width: 300) // Fixed width
                        
                        // Action Section
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
                        .frame(width: 100)
                        
                    } else if let error = userService.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
}

// MARK: - Alternative: Card-based Horizontal Layout
struct ProfileViewCards: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var userService = UserServiceViewModel()
    @State private var selectedUserId = 1
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    
                    if userService.isLoading {
                        ProgressView("Loading...")
                            .frame(width: 200, height: 300)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                    } else if let user = userService.user {
                        
                        // Profile Card
                        VStack(spacing: 15) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Text(String(user.name.prefix(1)))
                                        .font(.title)
                                        .foregroundColor(.white)
                                )
                            
                            Text(user.name)
                                .font(.headline)
                                .bold()
                            
                            Text(user.email)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .frame(width: 180, height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        
                        // Contact Card
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Contact")
                                .font(.headline)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Username: \(user.username)")
                                    .font(.caption)
                                Text("Website: \(user.website)")
                                    .font(.caption)
                            }
                        }
                        .frame(width: 180, height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        
                        // Address Card
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Location")
                                .font(.headline)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("City: \(user.address.city)")
                                    .font(.caption)
                                Text("Company: \(user.company.name)")
                                    .font(.caption)
                            }
                        }
                        .frame(width: 180, height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        
                        // Actions Card
                        VStack {
                            Button(action: {
                                cardManager.showProfile = false
                            }) {
                                Text("Back")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .frame(width: 180, height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        
                    } else if let error = userService.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .frame(width: 200, height: 300)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
}

// MARK: - Alternative: Grid Layout (2x2)
struct ProfileViewGrid: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var userService = UserServiceViewModel()
    @State private var selectedUserId = 1
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if userService.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let user = userService.user {
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        // Profile Picture
                        VStack(spacing: 10) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Text(String(user.name.prefix(1)))
                                        .font(.title)
                                        .foregroundColor(.white)
                                )
                            
                            Text(user.name)
                                .font(.headline)
                                .bold()
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Contact Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact")
                                .font(.headline)
                                .bold()
                            
                            Text(user.email)
                                .font(.caption)
                            Text(user.username)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Location Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Location")
                                .font(.headline)
                                .bold()
                            
                            Text("City: \(user.address.city)")
                                .font(.caption)
                            Text("Company: \(user.company.name)")
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Actions
                        VStack {
                            Button(action: {
                                cardManager.showProfile = false
                            }) {
                                Text("Back")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding()
                    
                } else if let error = userService.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
}
