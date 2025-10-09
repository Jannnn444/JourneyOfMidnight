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
            
            Image("bkg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                // Header
                HStack {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    // Close button
                    Button(action: {
                        cardManager.showLoginPage = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .padding()      // More padding at top for safe area
                    .padding(.trailing, 20)  // Padding from right edge
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 30) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300)

                    HStack {
                        Button(action: {
                            Task {
                                let result = await authViewModel.signIn(email: email ,password: password)
                                print(result)
                            }
                        }) {
                            Text("Sign In")
                                .padding()
                                .font(.subheadline)
                                .fontDesign(.monospaced)
                                .foregroundStyle(.white)
                                .bold()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            Task {
                                await authViewModel.signOut()
                            }
                        }) {
                            Text("Sign Out")
                                .padding()
                                .font(.subheadline)
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                                .bold()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(12)
                        }
                    }
                    
                    HStack {
                        // Vstack
                        Button(action: {
                            Task {
                                let result = await authViewModel.signUp(email: email,username: username ,password: password)
                                print(result)
                            }
                        }) {
                            Text("No account? Sign Up here")
                                .font(.subheadline)
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                            
                        }
                        
                        // here is inside HStack
                        
//                        if authViewModel.errorMessage != nil {
//                            Text("Error")
//                                .foregroundStyle(.red)
//                                .padding(.horizontal)
//                        }
//                        if authViewModel.succeedMessage != nil {
//                            Text("Succeeded: \(authViewModel.succeedMessage?.description ?? "") ")
//                                .foregroundStyle(.red)
//                                .padding(.horizontal)
//                        }
                        
                        if let errorMessage = authViewModel.errorMessage {
                            Text("Error")
                                    .foregroundStyle(.red)
                                    .padding(.horizontal)
                        }
                        
                        if let message = authViewModel.succeedMessage {
                            Text("Succeeded")
                                    .foregroundStyle(.red)
                                    .padding(.horizontal)
                        }
                    }
                     


                }
            }

        }
    }
}
