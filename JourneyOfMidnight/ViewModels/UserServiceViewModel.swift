//
//  UserService.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/9/18.
//

import Foundation

@Observable

// example

class UserServiceViewModel {
    private let baseURL = "https://jsonplaceholder.typicode.com"
     var user: User?
     var isLoading = false
     var errorMessage: String?
    
    @MainActor
    func fetchUser(id: Int = 1) async {
            isLoading = true
            errorMessage = nil
        
        
        guard let url = URL(string: "\(baseURL)/users/\(id)") else {
                errorMessage = "Invalid URL"
                isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedUser = try JSONDecoder().decode(User.self, from: data)
            
          
                self.user = fetchedUser
                self.isLoading = false

        } catch {
         
                self.errorMessage = "Failed to fetch user: \(error.localizedDescription)"
                self.isLoading = false
           
        }
    }
}
