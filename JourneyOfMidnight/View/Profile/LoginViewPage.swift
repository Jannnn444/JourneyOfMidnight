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
                .opacity(0.5)
            
            Color.black.opacity(0.5)
                .frame(width: 400, height: 200)

            VStack(spacing: 30) {
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                
                if let error = authViewModel.errorMessage {
                    Text("error")
                        .foregroundStyle(.accent)
                }
                
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
                        let result = await authViewModel.signUp(email: email,username: username ,password: password)
                        print(result)
                    }
                }) {
                    Text("Sign Up")
                        .padding()
                        .font(.subheadline)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
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
                
                Button(action: {
                    cardManager.showLoginPage = false
                }) {
                    Text("Closed")
                        .padding()
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
            }
        }
    }
}
