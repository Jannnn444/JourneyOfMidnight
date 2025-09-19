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
          ZStack {
              // Background Image - Full Screen Coverage
              Image("bkg")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .ignoresSafeArea(.all)
              
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
                                          Text(String(user.name.prefix(1)))
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
                                      Text("Username: \(user.username)")
                                      Text("Website: \(user.website)")
                                      Text("City: \(user.address.city)")
                                      Text("Company: \(user.company.name)")
                                  }
                                  .foregroundColor(.white)
                              }
                              .padding()
                              .background(Color.black.opacity(0.4))
                              .cornerRadius(8)
                              .frame(minWidth: 250) // Flexible width
                              
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
                      .frame(minWidth: geometry.size.width) // Ensure content is at least screen width
                  }
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


// MARK: - Alternative Fix: Full Screen Background
struct ProfileViewAlt: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var userService = UserServiceViewModel()
    @State private var selectedUserId = 1
    
    var body: some View {
        ZStack {
            // Background Image - Outside NavigationView for full coverage
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            NavigationView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        // Content (same as above but with better contrast)
                        if userService.isLoading {
                            VStack {
                                ProgressView()
                                    .tint(.white)
                                Text("Loading user...")
                                    .foregroundColor(.white)
                            }
                        } else if let user = userService.user {
                            
                            // Profile Picture Section
                            VStack(spacing: 15) {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Text(String(user.name.prefix(1)))
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
                            .frame(width: 200)
                            
                            // Basic Info Section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Personal Information")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Username: \(user.username)")
                                    Text("Website: \(user.website)")
                                    Text("City: \(user.address.city)")
                                    Text("Company: \(user.company.name)")
                                }
                                .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(8)
                            .frame(width: 300)
                            
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
                .navigationBarHidden(true)
            }
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
}

// MARK: - Simplified Fix: Remove Horizontal Scroll if Not Needed
struct ProfileViewSimple: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var userService = UserServiceViewModel()
    @State private var selectedUserId = 1
    
    var body: some View {
        ZStack {
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 30) { // Changed back to VStack if horizontal scroll isn't needed
                // Content
                if userService.isLoading {
                    VStack {
                        ProgressView()
                            .tint(.white)
                        Text("Loading user...")
                            .foregroundColor(.white)
                    }
                } else if let user = userService.user {
                    
                    // Profile Picture Section
                    VStack(spacing: 15) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Text(String(user.name.prefix(1)))
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
                    
                    // Basic Info Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Personal Information")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username: \(user.username)")
                            Text("Website: \(user.website)")
                            Text("City: \(user.address.city)")
                            Text("Company: \(user.company.name)")
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(8)
                    
                    // Action Section
                    Button(action: {
                        cardManager.showProfile = false
                    }) {
                        Text("Back")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                } else if let error = userService.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
        .task {
            await userService.fetchUser(id: selectedUserId)
        }
    }
}
