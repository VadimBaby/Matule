//
//  MainTextFieldStyle.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import Foundation
import SwiftUI

struct MainTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .padding(.leading)
            .background(Color.customLightGray)
            .clipShape(.rect(cornerRadius: 15))
            .customFont(weight: .medium, size: 14)
            .foregroundStyle(Color.customGray)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

#Preview {
    TextField("placeholder", text: .constant(""))
        .textFieldStyle(MainTextFieldStyle())
        .padding()
}
