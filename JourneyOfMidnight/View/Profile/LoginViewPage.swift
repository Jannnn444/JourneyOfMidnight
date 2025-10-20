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
    @ObservedObject var authViewModel: AuthViewModel  // ✅ Receive it as parameter
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
   
    var onLoginSuccess: () -> Void
    
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
                                if result == true {
                                    cardManager.showLoginPage = false    // ✅ Close login + navigate to profile
                                    onLoginSuccess()
                                    cardManager.isLoggedIn = true
                                }
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
                            // MARK: Pop SignUpView for create new account
                            cardManager.showSignUpView = true
                            
//     Task { await authViewModel.signUp(email: email,username: username ,password: password) }
                        }) {
                            Text("No account? Sign Up here")
                                .font(.subheadline)
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                            
                        }
                        .sheet(isPresented: $cardManager.showSignUpView) {
                            SignUpView(authViewModel: authViewModel)
                        }
                        // NOTE: Control show SignUpView @ CardManager
                        
                        if authViewModel.errorMessage != nil {
                            Text("\(authViewModel.errorMessage ?? "")")
                                    .foregroundStyle(.red)
                                    .padding(.horizontal)
                        } else if authViewModel.succeedSignUpMessage != nil {
                            Text("Succeeded:\n\(authViewModel.succeedSignUpMessage ?? "")")
                                    .foregroundStyle(.green)
                                    .padding(.horizontal)
                        } else if authViewModel.succeedSignInMessage != nil {
                            Text("Succeeded:\n\(authViewModel.succeedSignInMessage ?? "")")
                                    .foregroundStyle(.green)
                                    .padding(.horizontal)
                                    .onAppear {
                                        cardManager.showLoginPage = false
                                        onLoginSuccess()
                                        cardManager.isLoggedIn = true
                                        // ✅ Close login and navigate to profile
                                    }
                        }
                    }
                }
            }
        }
    }
}
