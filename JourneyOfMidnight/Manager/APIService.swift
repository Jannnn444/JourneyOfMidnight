//
//  APIService.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/10/2.
//

import Foundation
import SwiftUI

// MARK: - API Service
class APIService {
    static let shared = APIService()
    
    // Change this to your actual base URL
    private let baseURL = "http://10.2.201.208:4333"
    
    private let keychainManager = KeychainManager.shared
    
    private init() {}
    
    // MARK: - Token Management
    
    private func saveTokens(accessToken: String, refreshToken: String) {
        keychainManager.save(key: "access_token", value: accessToken)
        keychainManager.save(key: "refresh_token", value: refreshToken)
    }
    
    private func getAccessToken() -> String? {
        return keychainManager.get(key: "access_token")
    }
    
    func clearTokens() {
        keychainManager.delete(key: "access_token")
        keychainManager.delete(key: "refresh_token")
    }
    
    // MARK: - Network Request Helper
    
    private func performRequest<T: Decodable>(
        endpoint: String,
        method: String,
        body: Encodable? = nil,
        requiresAuth: Bool = false
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth, let token = getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Decoding error: \(error)")
                throw APIError.decodingError
            }
        case 401:
            throw APIError.unauthorized
        default:
            if let errorMessage = String(data: data, encoding: .utf8) {
                throw APIError.serverError(errorMessage)
            }
            throw APIError.serverError("Unknown error")
        }
    }
    
    // MARK: - API Endpoints
    
    func signUp(email: String, username: String, password: String) async throws -> SignUpResponse {
        let requestBody = SignUpRequest(email: email, username: username, password: password)
        return try await performRequest(
            endpoint: "/api/user/signup",
            method: "POST",
            body: requestBody
        )
    }
    
    func signIn(email: String, password: String) async throws -> SignInResponse {
        let requestBody = SignInRequest(email: email, password: password)
        let response: SignInResponse = try await performRequest(
            endpoint: "/api/user/signin",
            method: "POST",
            body: requestBody
        )
        
        // Save tokens to keychain
        saveTokens(accessToken: response.accessToken, refreshToken: response.refreshToken)
        
        return response
    }
    
    func getUserProfile() async throws -> UserProfile {
        return try await performRequest(
            endpoint: "/api/user/profile",
            method: "GET",
            requiresAuth: true
        )
    }
}

// MARK: - Example ViewModel


@Observable
class AuthViewModel {
    var isLoading = false
    var errorMessage: String?
    var isAuthenticated = false
    var currentUser: User?
    var userProfile: UserProfile?
    
    private let apiService = APIService.shared
    
    @MainActor
    func signUp(email: String, username: String, password: String) async -> String {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await apiService.signUp(email: email, username: username, password: password)
            print(response.message)
            isLoading = false
            return String("Sign up succeed!")
        } catch {
            errorMessage = error.localizedDescription
            return String("Sign up failed")
        }
    }
    
    func signIn(email: String, password: String) async -> String {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await apiService.signIn(email: email, password: password)
            currentUser = response.user
            isAuthenticated = true
            // Optionally fetch profile after login
            await fetchUserProfile()
            isLoading = false
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
