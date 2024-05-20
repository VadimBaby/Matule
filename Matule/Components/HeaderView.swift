//
//  HeaderView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 13.05.2024.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String?
    let rightIcon: String?
    let dismiss: (() -> Void)?
    
    var body: some View {
        HStack {
            if let dismiss {
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
            } else {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 44, height: 44)
            }
            
            if let title {
                Text(title)
                    .customFont(weight: .medium, size: 20)
                    .foregroundStyle(Color.customBlack)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Spacer()
            }
            
            if let rightIcon {
                Circle()
                    .fill(Color.white)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: rightIcon)
                            .font(.title3)
                    }
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(Color.customRed)
                            .frame(width: 8, height: 8)
                            .offset(x: -2, y: 4)
                    }
            } else {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HeaderView(title: "Title", rightIcon: "bag") {
        
    }
}
