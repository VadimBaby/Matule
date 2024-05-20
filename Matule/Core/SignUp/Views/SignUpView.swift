//
//  SignUpView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import SwiftUI
import NavigationTransitions

struct SignUpView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var radio: Bool = false
    
    @State private var emailError: Bool = false
    
    @State private var navigate: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Register Account")
                        .asTitle()
                    Text("Fill your details or continue with\nsocial media")
                        .asSubtitle()
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your Name")
                        .customFont(weight: .regular, size: 16)
                        .foregroundStyle(Color.customBlack)
                    
                    TextField("Name", text: $name)
                        .textFieldStyle(MainTextFieldStyle())
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
            
            HStack {
                RadioButton(value: $radio)
                NavigationLink {
                    PDFDocumentView()
                } label: {
                    Text("Даю согласие на обработку\nперсональных данных")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.primaryGray)
                        .underline()
                        .customFont(weight: .medium, size: 16)
                }
                Spacer()

            }
            .padding(.vertical)
            
            Button("Sign Up") {
                signUp()
            }
            .buttonStyle(BlueButtonStyle())
            
            Spacer()
            
            HStack {
                Text("Already Have Account?")
                    .foregroundStyle(Color.customGray)
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Log In")
                        .foregroundStyle(Color.customBlack)
                }
            }
            .customFont(weight: .medium, size: 16)

        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert("Email error", isPresented: $emailError) {
            
        }
        .navigationDestination(isPresented: $navigate) {
            SignInView()
        }
    }
    
    private func signUp() {
        guard email.isValidateEmail else {
            self.emailError = true
            return
        }
        
        guard !name.isEmpty && password.count > 4 && password.count < 14 && radio else { return }
        
        Task {
            do {
                try await SupabaseManager.instance.signUp(name: name, email: email, password: password)
                
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
    NavigationStack {
        SignUpView()
    }
    .navigationTransition(.fade(.cross))
}
