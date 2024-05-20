//
//  RadioButton.swift
//  Matule
//
//  Created by Вадим Мартыненко on 11.05.2024.
//

import SwiftUI

struct RadioButton: View {
    
    @Binding var value: Bool
    
    var body: some View {
        Circle()
            .fill(Color.customLightGray)
            .frame(width: 23, height: 23)
            .overlay {
                if value {
                    Image("shield_checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
            }
            .onTapGesture {
                value.toggle()
            }
    }
}

#Preview {
    RadioButton(value: .constant(false))
}
