//
//  View.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import Foundation
import SwiftUI

extension View {
    func customFont(weight: Font.Weight = .regular, size: CGFloat) -> some View {
        switch weight {
        case .black:
            self
                .font(.custom("Raleway Black", size: size))
        case .bold:
            self
                .font(.custom("Raleway Bold", size: size))
        case .light:
            self
                .font(.custom("Raleway Light", size: size))
        case .medium:
            self
                .font(.custom("Raleway Medium", size: size))
        default:
            self
                .font(.custom("Raleway Regular", size: size))
        }
    }
    
    func asTitle(color: Color = Color.customBlack) -> some View {
        self
            .customFont(weight: .bold, size: 32)
            .foregroundStyle(color)
    }
    
    func asSubtitle(color: Color = Color.customGray) -> some View {
        self
            .customFont(weight: .medium, size: 16)
            .foregroundStyle(color)
    }
    
    func addHeader(title: String?, rightIcon: String?, dismiss: (() -> Void)?) -> some View {
        ZStack {
            Color.customLightGray.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HeaderView(title: title, rightIcon: rightIcon, dismiss: dismiss)
                
                VStack(spacing: 0) {
                    self
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
