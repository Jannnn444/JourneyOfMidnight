//
//  PersonalProfileView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/18.
//

import SwiftUI

// MARK: - Profile View
struct ProfileView: View {
    @StateObject private var userService = UserService()
    @State private var selectedUserId = 1
    
    var body: some View {
        NavigationView {
            ScrollView {
            VStack(spacing: 20) {
                // User Selection
                Picker("Select User", selection: $selectedUserId) {
                    ForEach(1...10, id: \.self) { id in
                        Text("User \(id)").tag(id)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedUserId) { newId in
                    Task {
                        await userService.fetchUser(id: newId)
                    }
                }
                
                // Content
                if userService.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let user = userService.user {
                    // Simple Profile Display
                    VStack(spacing: 15) {
                        // Profile Picture
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text(String(user.name.prefix(1)))
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            )
                        
                        // Basic Info
                        Text(user.name)
                            .font(.title2)
                            .bold()
                        
                        Text(user.email)
                            .foregroundColor(.blue)
                        
//                        Text(user.phone)
//                          .foregroundColor(.gray)
                        
                        // Simple Info List
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username: \(user.username)")
                            Text("Website: \(user.website)")
                            Text("City: \(user.address.city)")
                            Text("Company: \(user.company.name)")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .padding()
                } else if let error = userService.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
            }
//          .navigationTitle("Profile")
            .padding()
        }
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
    
    // add button for go back to main menu
    // add button for return
}

// MARK: - Reusable Components
struct InfoSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(spacing: 10) {
                content
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
}
