//
//  AuthViewModel.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/10/9.
//

import SwiftUI

@Observable
class AuthViewModel {
    var isLoading = false
    var errorMessage: String?
    var succeedSignupMessage: String?
    var succeedSignInMessage: String?
    var isAuthenticated = false
    var currentUser: User?
    var userProfile: UserProfile?
    
    private let apiService = APIService.shared
    
    @MainActor
    func signUp(email: String, username: String, password: String) async -> String {
        isLoading = true
        errorMessage = nil
        succeedSignupMessage = nil
        
        do {
            let response = try await apiService.signUp(email: email, username: username, password: password)
            print(response.message)
            isLoading = false
            succeedSignupMessage = "Signup Succeeded"
            return String("Sign up succeed!")
        } catch {
            errorMessage = error.localizedDescription
            return String("Sign up failed")
        }
    }
    
    func signIn(email: String, password: String) async -> String {
        isLoading = true
        errorMessage = nil
        succeedSignInMessage = nil
        
        do {
            let response = try await apiService.signIn(email: email, password: password)
            currentUser = response.user
            isAuthenticated = true
            
            
            // 🎯 Print the response here
                  print("=== Login Success ===")
                  print("📧 User Email: \(response.user.email)")
                  print("🆔 User ID: \(response.user.id)")
                  print("✅ Email Verified: \(response.user.emailVerified)")
                  print("🔑 Access Token: \(response.accessToken)")
                  print("🔄 Refresh Token: \(response.refreshToken)")
                  print("=====================\n")
                  
                  currentUser = response.user
                  isAuthenticated = true
                  
            
            // Optionally fetch profile after login
            await fetchUserProfile()
            isLoading = false
            succeedSignInMessage = "Signin succeeded"
            return String("Sign in succeed!")
        } catch {
            errorMessage = error.localizedDescription
            return String("Sign in failed")
        }
    }
    
    func fetchUserProfile() async {
        do {
            userProfile = try await apiService.getUserProfile()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut() -> String {
        apiService.clearTokens()
        isAuthenticated = false
        currentUser = nil
        userProfile = nil
        return String("Sign out succeed!")
    }
}

// MARK: - Example View Usage
@MainActor
struct LoginView: View {
    @State private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                Task {
                    await viewModel.signIn(email: email, password: password)
                }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Sign In")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)
        }
        .padding()
    }
}

@MainActor
struct ProfileView: View {
    @State private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let profile = viewModel.userProfile {
                Text("Username: \(profile.username)")
                Text("Reputation: \(profile.reputation)")
                Text("Total Playtime: \(profile.totalPlaytime)")
                
                Button("Sign Out") {
                    viewModel.signOut()
                }
                .buttonStyle(.bordered)
            } else if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchUserProfile()
        }
    }
}
