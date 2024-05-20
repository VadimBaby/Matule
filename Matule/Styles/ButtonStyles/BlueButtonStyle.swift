//
//  BlueButtonStyle.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import Foundation
import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    
    let disable: Bool
    
    init(disable: Bool = false) {
        self.disable = disable
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(disable ? Color.customGray : Color.customLightBlue)
            .clipShape(.rect(cornerRadius: 15))
            .customFont(weight: .medium, size: 16)
            .foregroundStyle(Color.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

#Preview {
    Button("Button") {
        
    }
    .buttonStyle(BlueButtonStyle())
}
