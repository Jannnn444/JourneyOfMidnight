//
//  AuthViewModel.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/10/9.
//

import SwiftUI

class AuthViewModel: ObservableObject { 
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var succeedSignUpMessage: String?
    @Published var succeedSignInMessage: String?
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var userProfile: UserProfile?
    
    private let apiService = APIService.shared
    
    @MainActor
    func signUp(email: String, username: String, password: String) async -> String {
        isLoading = true
        errorMessage = nil
        succeedSignUpMessage = nil
        
        do {
            let response = try await apiService.signUp(email: email, username: username, password: password)
            print(response.message)
            isLoading = false
            succeedSignUpMessage = "Signup Succeeded"
            return String("Sign up succeed!")
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return String("Sign up failed")
        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async -> Bool {
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
            
            // Optionally fetch profile after login
            await fetchUserProfile()
            isLoading = false
            succeedSignInMessage = "Signin succeeded"
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    @MainActor
    func fetchUserProfile() async {
        isLoading = true
        errorMessage = nil
        
        do {
            userProfile = try await apiService.getUserProfile()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    

    @MainActor
    func signOut() -> String {
        apiService.clearTokens()
        isAuthenticated = false
        currentUser = nil
        userProfile = nil  // Clear profile data on sign out
        return String("Sign out succeed!")
    }
}

