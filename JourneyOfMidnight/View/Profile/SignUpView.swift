//
//  SignUpView.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/10/13.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var cardManager = CardManager.shared
    @ObservedObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirming = ""
    
    var body: some View {
        VStack(alignment: .center) {
            
            // MARK: Title
            HStack {
                Text("Sign Up Now!")
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
                
                Button(action: {
                    cardManager.showSignUpView = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.gray)
                }
                .padding()
                .padding(.trailing,20)
            }.padding(.horizontal) //here's title padding left and right
            
            // MARK: Fields
            VStack(alignment: .leading, spacing: 30) {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.default)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                SecureField("Confirm Password", text: $passwordConfirming)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                
                HStack{
                    Button(action: {
                        Task {
                            if self.password == self.passwordConfirming {
                                let result = await authViewModel.signUp(email: email, username: username, password: password)
                                print(result)
                            } else {
                                // MARK: 2 Passwords is different
                                PopupView(content: {
                                    Text("Please reconfirm 2 Password is the same!")
                                        .fontDesign(.monospaced)
                                        .foregroundStyle(.red)
                                })
                            }
                        }
                    }) {
                        Text("Sign Up")
                            .padding()
                            .font(.subheadline)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                            .bold()
                            .foregroundStyle(.gray)
                            .bold()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                    }
                }
            }
        }
        
    }
}

