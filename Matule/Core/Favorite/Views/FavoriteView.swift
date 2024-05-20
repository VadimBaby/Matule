//
//  FavoriteView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 14.05.2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(homeViewModel.products.filter({$0.isHeart}).indices, id: \.self) { index in
                        let products = homeViewModel.products.filter({$0.isHeart})
                        
                        if index.isMultiple(of: 0) || index.isMultiple(of: 2) {
                            HStack(spacing: 20) {
                                ProductCard(
                                    id: products[index].id,
                                    name: products[index].name,
                                    price: products[index].price,
                                    isHeart: products[index].isHeart
                                )
                                if index + 1 < products.count {
                                    ProductCard(
                                        id: products[index + 1].id,
                                        name: products[index + 1].name,
                                        price: products[index + 1].price,
                                        isHeart: products[index + 1].isHeart
                                    )
                                } else { Spacer() }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .addHeader(title: "Избранное", rightIcon: "heart") {
            dismiss()
        }
    }
}

#Preview {
    FavoriteView()
        .environmentObject(HomeViewModel())
}
