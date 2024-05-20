//
//  GeneratePasswordSheet.swift
//  Matule
//
//  Created by Вадим Мартыненко on 11.05.2024.
//

import SwiftUI

struct GeneratePasswordSheet: View {
    
    @State private var phrase: String = ""
    
    @State private var password: String = ""
    
    let savePassword: (_ password: String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("Введите фразу", text: $phrase)
                .textFieldStyle(MainTextFieldStyle())
            
            Button("Сгенерировать пароль") {
                password = phrase.turnToPassword()
            }
            .buttonStyle(BlueButtonStyle(disable: phrase.count < 8))
            .disabled(phrase.count < 8)
            
            Text(password)
                .textSelection(.enabled)
                .customFont(weight: .medium, size: 20)
            
            Spacer()
            
            Button("Сохранить пароль") {
                savePassword(password)
                dismiss()
            }
            .buttonStyle(BlueButtonStyle(disable: password.count < 8))
            .disabled(password.count < 8)
        }
        .padding()
    }
}

#Preview {
    GeneratePasswordSheet(savePassword: { _ in
        
    })
}
