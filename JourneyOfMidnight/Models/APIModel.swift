//
//  APIModel.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/30.
//

import Foundation

// MARK: - Models

struct SignUpRequest: Codable {
    let email: String
    let username: String
    let password: String
}

struct SignUpResponse: Codable {
    let message: String
}

struct SignInRequest: Codable {
    let email: String
    let password: String
}

struct SignInResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case user
    }
}

struct User: Codable, Identifiable {
    let id: String
    // let icon: Int
    let email: String
    let emailVerified: Bool
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, email /*, icon*/
        case emailVerified = "email_verified"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct UserProfile: Codable, Identifiable {
    let id: String
    let userId: String
    let username: String
    let reputation: Int
    let totalPlaytime: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case username, reputation
        case totalPlaytime = "total_playtime"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct UserProfileUpdate: Codable {
    let id: String?
    let icon: Int?
    let userId: String?
    let username: String?
    let reputation: Int?
    let totalPlaytime: Int?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, icon
        case userId = "user_id"
        case username, reputation
        case totalPlaytime = "total_playtime"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - API Error
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(String)
    case decodingError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .unauthorized:
            return "Unauthorized. Please log in again."
        case .serverError(let message):
            return message
        case .decodingError:
            return "Failed to decode response"
        case .noData:
            return "No data received"
        }
    }
}

// MARK: - Keychain Manager

class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    func save(key: String, value: String) {
        let data = Data(value.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

