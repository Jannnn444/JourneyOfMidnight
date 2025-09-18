//
//  UserService.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/18.
//

import Foundation

class UserService: ObservableObject {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchUser(id: Int = 1) async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        guard let url = URL(string: "\(baseURL)/users/\(id)") else {
            await MainActor.run {
                errorMessage = "Invalid URL"
                isLoading = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedUser = try JSONDecoder().decode(User.self, from: data)
            
            await MainActor.run {
                self.user = fetchedUser
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to fetch user: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}


