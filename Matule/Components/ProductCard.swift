//
//  ProductCard.swift
//  Matule
//
//  Created by Вадим Мартыненко on 13.05.2024.
//

import SwiftUI

struct ProductCard: View {
    
    let id: String
    let name: String
    let price: Int
    let isHeart: Bool
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    init(id: String = "1", name: String = "Nike Air Max", price: Int = 752, isHeart: Bool = true) {
        self.id = id
        self.name = name
        self.price = price
        self.isHeart = isHeart
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .frame(width: 160, height: 187)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 8) {
                    Circle()
                        .fill(Color.customLightGray)
                        .frame(width: 28, height: 28)
                        .overlay {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(isHeart ? Color.customRed : Color.white)
                                .font(.subheadline)
                        }
                        .onTapGesture {
                            homeViewModel.toggleHeart(id: id)
                        }
                    Image("sneaker")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 115, height: 55)
                    Text("Best Seller".uppercased())
                        .foregroundStyle(Color.customBlue)
                        .customFont(weight: .medium, size: 12)
                    Text(name)
                        .foregroundStyle(Color.darkGray)
                        .customFont(weight: .medium, size: 16)
                    HStack {
                        Text("₽\(price).00")
                            .foregroundStyle(Color.customBlack)
                            .customFont(weight: .medium, size: 14)
                        Spacer()
                        Rectangle()
                            .fill(Color.customBlue)
                            .frame(width: 34, height: 35)
                            .clipShape(.rect(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 15, topTrailingRadius: 0, style: .circular))
                            .overlay {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundStyle(Color.white)
                            }
                    }
                }
                .padding(.leading)
            }
    }
}

#Preview {
    ZStack {
        Color.customLightGray.ignoresSafeArea()
        
        ProductCard()
    }
    .environmentObject(HomeViewModel())
}
