//
//  ForgotPasswordView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var emailError: Bool = false
    @State private var navigate: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Button(action: {
                    dismiss()
                }, label: {
                    Circle()
                        .fill(Color.customLightGray)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.customBlack)
                        }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Forgot Password")
                    .asTitle()
                Text("Enter your Email account to reset\nyour password")
                    .asSubtitle()
                    .multilineTextAlignment(.center)
            }
            
            TextField("Email", text: $email)
                .textFieldStyle(MainTextFieldStyle())
            
            Button("Reset Password") {
                resetPassword()
            }
            .buttonStyle(BlueButtonStyle())
            .padding(.top, 24)
            
            Spacer()
            
            NavigationLink(
                destination: OTPVierificationView(email: email),
                isActive: $navigate,
                label: {
                    EmptyView()
                })
        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert("Email error", isPresented: $emailError) {
            
        }
    }
    
    private func resetPassword() {
        guard email.isValidateEmail else { emailError = true; return }
        
        Task {
            do {
                try await SupabaseManager.instance.resetPassword(email: email)
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
    ForgotPasswordView()
}
