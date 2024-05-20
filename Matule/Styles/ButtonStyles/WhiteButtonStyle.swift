//
//  WhiteButtonStyle.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import SwiftUI

struct WhiteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 15))
            .customFont(weight: .medium, size: 14)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

#Preview {
    ZStack {
        Color.pink.ignoresSafeArea()
        
        Button("Next") {
            
        }
        .buttonStyle(WhiteButtonStyle())
        .padding()
    }
}
