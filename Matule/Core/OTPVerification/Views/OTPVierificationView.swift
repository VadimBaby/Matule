//
//  OTPVierificationView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 11.05.2024.
//

import SwiftUI

struct OTPVierificationView: View {
    @State private var openSheet: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var code: [String] = Array(repeating: "", count: 6)
    
    @State private var seconds = 60
    
    @State private var navigate: Bool = false
    
    let email: String
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common)
        .autoconnect()
    
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
                
                Text("OTP Проверка")
                    .asTitle()
                Text("Пожалуйста, проверьте свою\nэлектронную почту, чтобы увидеть\nкод подтверждения".capitalized)
                    .asSubtitle()
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .leading) {
                Text("OTP Код")
                    .foregroundStyle(Color.customBlack)
                    .customFont(weight: .medium, size: 21)
                
                HStack {
                    ForEach(code.indices, id: \.self) { index in
                        codeTextField(value: $code[index])
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            
            HStack {
                Button("Отправить заново") {
                    
                }
                .disabled(seconds > 0)
                
                Spacer()
                
                if seconds > 0 {
                    Text(seconds == 60 ? "01:00" : seconds > 9 ? "00:\(seconds)" : "00:0\(seconds)")
                        .customFont(weight: .regular, size: 16)
                        .foregroundStyle(Color.customGray)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $openSheet, content: {
            GeneratePasswordSheet { password in
                Task {
                    do {
                        try await SupabaseManager.instance.updatePassword(password: password)
                        await MainActor.run {
                            self.navigate = true
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        })
        .onReceive(timer, perform: { _ in
            seconds -= 1
            
            if seconds <= 0 {
                stopTimer()
            }
        })
        .onChange(of: code) { _, newValue in
            let isEmpty = newValue.reduce(false) { partialResult, value in
                if partialResult {
                    return true
                }
                
                return value.isEmpty
            }
            
            if !isEmpty {
                verifyOTP(code: newValue)
            }
        }
        .navigationDestination(isPresented: $navigate) {
           HomeView()
        }
    }
    
    private func verifyOTP(code: [String]) {
        let token = code.reduce("") { partialResult, letter in
            return partialResult + letter
        }
        
        Task {
            do {
                try await SupabaseManager.instance.verifyOTP(token: token, email: email)
                
                await MainActor.run {
                    self.openSheet = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

extension OTPVierificationView {
    @ViewBuilder private func codeTextField(value: Binding<String>) -> some View {
        TextField("", text: value)
            .multilineTextAlignment(.center)
            .frame(width: 46, height: 99)
            .background(Color.customLightGray)
            .clipShape(.rect(cornerRadius: 15))
            .customFont(weight: .bold, size: 22)
    }
}

#Preview {
    OTPVierificationView(email: "")
}
