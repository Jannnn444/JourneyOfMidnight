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
    @State private var showPasswordMismatchAlert = false
    @State private var showSuccessSignedUp = false
    
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
                
                TextField("Email", text: $email)
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

                                         if authViewModel.succeedSignUpMessage != nil {
                                             showSuccessSignedUp = true
                                         }
                            } else {
                                // MARK: When 2 Passwords is different
                              showPasswordMismatchAlert = true
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
            .alert("Password Mismatch", isPresented: $showPasswordMismatchAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please reconfirm 2 Password is correct")
                    .foregroundStyle(.red)
                    .fontDesign(.monospaced)
            }
            .alert("Welcome!", isPresented: $showSuccessSignedUp) {
                Button("OK", action: {
                    cardManager.showSignUpView = false
                    showSuccessSignedUp = false
                })
            } message: {
                Text("Sign up success")
                    .foregroundStyle(.green)
                    .fontDesign(.monospaced)
            }
            
            if authViewModel.succeedSignUpMessage != nil {
                Text("Succeeded:\n\(authViewModel.succeedSignUpMessage ?? "")")
                        .foregroundStyle(.green)
                        .padding(.horizontal)
            }

            
        } //VStack
        
        
    }
}

