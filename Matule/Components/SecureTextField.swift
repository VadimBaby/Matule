//
//  SecureTextField.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import SwiftUI

struct SecureTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(MainTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(MainTextFieldStyle())
            }
            
            Button(action: {
                self.isSecure.toggle()
            }, label: {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .font(.callout)
                    .foregroundStyle(Color.customGray)
            })
            .padding(.trailing)
        }
    }
}

#Preview {
    SecureTextField(placeholder: "placeholder", text: .constant(""))
}
