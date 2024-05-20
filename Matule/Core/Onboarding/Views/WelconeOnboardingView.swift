//
//  WelconeOnboardingView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import SwiftUI

struct WelconeOnboardingView: View {
    var body: some View {
            ZStack(alignment: .trailing) {
                Image("leg_sneaker")
                
                HStack {
                    ForEach(0...2, id: \.self) { index in
                        if index.isMultiple(of: 0) {
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
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y: 180)
                
                VStack {
                    Text("WELCOME TO\nNIKE")
                        .customFont(weight: .black, size: 30)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .padding(.top, 50)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }
        }
}

#Preview {
    WelconeOnboardingView()
}
