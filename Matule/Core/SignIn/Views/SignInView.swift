//
//  SignInView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var emailError: Bool = false
    
    @State private var navigate: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Hello Again!")
                        .asTitle()
                    Text("Fill your details or continue with\nsocial media")
                        .asSubtitle()
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Email Address")
                        .customFont(weight: .regular, size: 16)
                        .foregroundStyle(Color.customBlack)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(MainTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Password")
                        .customFont(weight: .regular, size: 16)
                        .foregroundStyle(Color.customBlack)
                    
                    SecureTextField(placeholder: "Password", text: $password)
                }
            }
            
            NavigationLink {
                ForgotPasswordView()
            } label: {
                Text("Recovery Password")
                    .customFont(weight: .medium, size: 15)
                    .foregroundStyle(Color.customGray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 12)
            }

            
            Button("Sign In") {
                signIn()
            }
            .buttonStyle(BlueButtonStyle())
            .padding(.top, 24)
            
            Spacer()

            HStack {
                Text("New User?")
                    .foregroundStyle(Color.customGray)
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Create Account")
                        .foregroundStyle(Color.customGray)
                }
            }
            .customFont(weight: .medium, size: 16)
        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert("Email error", isPresented: $emailError) {
            
        }
        .navigationDestination(isPresented: $navigate) {
            HomeView()
        }
    }
    
    private func signIn() {
        guard email.isValidateEmail else {
            self.emailError = true
            return
        }
        
        guard password.count > 4 && password.count < 14 else { return }
        
        Task {
            do {
                try await SupabaseManager.instance.signIn(email: email, password: password)
                
                await MainActor.run {
                    self.navigate = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    SignInView()
}
