//
//  UserProfileView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/9/27.
// 

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var cardManager = CardManager.shared
    @ObservedObject var authViewModel: AuthViewModel  // ✅ Receive it as parameter
    @Environment(\.dismiss) private var dismiss
    
        var body: some View {
            ZStack {
                Color.black.opacity(0.9).ignoresSafeArea()
               
                Rectangle()
                    .foregroundStyle(.blue.opacity(0.5))
                    .frame(width: 450, height: 300)
                    .cornerRadius(20)
                    .overlay (
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 8)
                    )
                
                VStack {
                    // ✅ Show loading state
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                    }
                    // ✅ Show profile data when available
                    else if let profile = authViewModel.userProfile {
                        HStack {
                            VStack(alignment: .leading, spacing: 12) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(.blue)
                                        .cornerRadius(12)
                                    
                                    Image("villager")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                            }.padding()
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Username")
                                    .foregroundStyle(.blue)
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                                    .fontWeight(.bold)
                                
                                Text(profile.username.isEmpty ? "Empty" : profile.username)
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .fontDesign(.monospaced)
                                
                                
                                Text("Reputation")
                                    .foregroundStyle(.blue)
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                                
                                HStack {
                                    // ✅ Display reputation stars based on actual value
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < profile.reputation ? "diamond.fill" : "diamond")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundStyle(.orange)
                                    }
                                }
                                
                                Text("Total Playtime: \(profile.totalPlaytime) minutes")
                                    .foregroundStyle(.gray)
                                    .font(.subheadline)
                                    .fontDesign(.monospaced)
                                
                                Text("Member since: \(formatDate(profile.createdAt).components(separatedBy: "T")[0])")
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                                
                                Text(" ------------------------------- ")
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                                
                                Text("Data Updated: \(profile.updatedAt.components(separatedBy: "T")[0])")
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                                
                            }
                        }.padding()
                    }
                    // ✅ Show error if any
                    else if let error = authViewModel.errorMessage {
                        VStack {
                            Text("Failed to load profile")
                                .foregroundStyle(.red)
                                .font(.headline)
                            
                            Text(error)
                                .foregroundStyle(.gray)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Button("Retry") {
                                Task {
                                    await authViewModel.fetchUserProfile()
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                    
                    // MARK: Close to main page
                    Button(action: {
                        cardManager.showProfile = false
                        dismiss()
                    }) {
                        Text("Close")
                            .padding()
                            .font(.caption)
                            .foregroundStyle(.black)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                    }
                }
            }
            // ✅ Fetch profile when view appears
            .task {
                await authViewModel.fetchUserProfile()
            }
        }
        
        // Helper function to format date
        private func formatDate(_ dateString: String) -> String {
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: dateString) {
                let displayFormatter = DateFormatter()
                displayFormatter.dateStyle = .medium
                return displayFormatter.string(from: date)
            }
            return dateString
        }
    }

#Preview {
    UserProfileView(authViewModel: AuthViewModel())
}
