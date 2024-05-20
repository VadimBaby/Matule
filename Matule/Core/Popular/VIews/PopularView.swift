//
//  PopularView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 13.05.2024.
//

import SwiftUI

struct PopularView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(homeViewModel.products.indices, id: \.self) { index in
                        let products = homeViewModel.products
                        
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
        .addHeader(title: "Популярное", rightIcon: "heart") {
            dismiss()
        }
    }
}

#Preview {
    PopularView()
        .environmentObject(HomeViewModel())
}
