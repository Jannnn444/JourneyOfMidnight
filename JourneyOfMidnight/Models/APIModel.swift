//
//  APIModel.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/30.
//

import Foundation

// Endpoint.swift
enum Endpoint {
    // Game Data API
    case getHeroes
    case getEnemies(level: Int)
    case getStories
    
    // User API
    case login(email: String, password: String)
    case saveProgress(userId: String, state: GameState)
    
    // Shop API
    case getVendorGoods
    case purchaseItem(itemId: String, userId: String)
    
    var baseURL: String {
        switch self {
        case .getHeroes, .getEnemies, .getStories:
            return "https://api.yourgame.com/v1/gamedata"
        case .login, .saveProgress:
            return "https://api.yourgame.com/v1/user"
        case .getVendorGoods, .purchaseItem:
            return "https://api.yourgame.com/v1/shop"
        }
    }
    
    var path: String {
        switch self {
        case .getHeroes: return "/heroes"
        case .getEnemies: return "/enemies"
        case .getStories: return "/stories"
        case .login: return "/login"
        case .saveProgress: return "/progress"
        case .getVendorGoods: return "/goods"
        case .purchaseItem: return "/purchase"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHeroes, .getEnemies, .getStories, .getVendorGoods:
            return .get
        case .login, .saveProgress, .purchaseItem:
            return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add query parameters or body based on endpoint
        switch self {
        case .getEnemies(let level):
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [URLQueryItem(name: "level", value: "\(level)")]
            request.url = components?.url
            
        case .login(let email, let password):
            let body = ["email": email, "password": password]
            request.httpBody = try? JSONEncoder().encode(body)
            
        case .saveProgress(let userId, let state):
            let body = ["userId": userId, "gameState": state]
            request.httpBody = try? JSONEncoder().encode(body)
            
        case .purchaseItem(let itemId, let userId):
            let body = ["itemId": itemId, "userId": userId]
            request.httpBody = try? JSONEncoder().encode(body)
            
        default:
            break
        }
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


// APIError.swift
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .decodingError:
            return "Failed to decode response"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
