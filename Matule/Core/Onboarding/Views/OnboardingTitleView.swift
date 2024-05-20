//
//  OnboardingTitleView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import SwiftUI

struct OnboardingTitleView: View {
    
    let id: Int
    let image: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
            
            Text(title)
                .customFont(weight: .bold, size: 34)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
            
            Text(subtitle)
                .customFont(weight: .regular, size: 16)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.secondaryGray)
            
            HStack {
                ForEach(1...Constants.queue.count, id: \.self) { index in
                    if index == id {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .frame(width: 42, height: 5)
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.customOrange)
                            .frame(width: 28, height: 5)
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        Color.customBlue.ignoresSafeArea()
        
        OnboardingTitleView(id: 2, image: "jordan_sneaker", title: "Let's Start Journey With Nike", subtitle: "Smart, Gorgeous & Fashionable Collection Explor Now")
    }
}
