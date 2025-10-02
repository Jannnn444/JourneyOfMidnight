//
//  LoginView.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/10/2.
//

import SwiftUI

@MainActor
struct LoginViewPage: View {
    @ObservedObject var cardManager = CardManager.shared
    @State private var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Login View")
                    .padding()
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                    .bold()
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                if let error = authViewModel.errorMessage {
                    Text("error")
                        .foregroundStyle(.accent)
                }
                
                HStack {
                    
                Button(action: {
                    Task {
                        await authViewModel.signIn(email: email ,password: password)
                    }
                }) {
                    Text("Sign In")
                        .padding()
                        .font(.title)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .bold()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
                
                Button(action: {
                    Task {
                        await authViewModel.signUp(email: email,username: username ,password: password)
                    }
                }) {
                    Text("Sign Up")
                        .padding()
                        .font(.title)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                        .bold()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
            }
                
                Button(action: {
                    cardManager.showLoginPage = false
                }) {
                    Text("Closed")
                        .padding()
                        .font(.caption)
                        .foregroundStyle(.black)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
            }
        }
    }
}
