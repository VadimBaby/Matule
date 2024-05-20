//
//  RealHomeView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 12.05.2024.
//

import SwiftUI

struct RealHomeView: View {
    
    @State private var search: String = ""
    
    private let categories: [String] = ["Все", "Outdoor", "Tennis", "Basketball", "Football"]
    
    var body: some View {
        ZStack {
            Color.customLightGray.ignoresSafeArea()
            
            VStack(spacing: 24) {
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                    Text("Главная")
                        .customFont(weight: .bold, size: 32)
                        .foregroundStyle(Color.customBlack)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "bag")
                                .font(.title3)
                        }
                        .overlay(alignment: .topTrailing) {
                            Circle()
                                .fill(Color.customRed)
                                .frame(width: 8, height: 8)
                                .offset(x: -2, y: 4)
                        }
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    TextField("Поиск", text: $search)
                        .customFont(weight: .regular, size: 12)
                        .foregroundStyle(Color.customBlack)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .leading) {
                            Image(systemName: "magnifyingglass")
                                .offset(x: -30)
                        }
                        .padding(.leading, 50)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 15))
                    Circle()
                        .fill(Color.customBlue)
                        .frame(width: 52, height: 52)
                        .overlay {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundStyle(Color.white)
                                .font(.title2)
                        }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Категории")
                        .customFont(weight: .medium, size: 20)
                        .foregroundStyle(Color.customBlack)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { category in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(width: 108, height: 40)
                                    .overlay {
                                        Text(category)
                                            .foregroundStyle(Color.customBlack)
                                            .customFont(weight: .regular, size: 15)
                                    }
                            }
                        }
                        .padding(.leading)
                    }
                    .scrollIndicators(.hidden)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Популярное")
                            .customFont(weight: .medium, size: 20)
                            .foregroundStyle(Color.customBlack)
                        Spacer()
                        NavigationLink {
                            PopularView()
                        } label: {
                            Text("Все")
                                .customFont(weight: .medium, size: 15)
                                .foregroundStyle(Color.customBlue)
                        }

                    }
                
                    HStack {
                        ProductCard()
                        Spacer()
                        ProductCard()
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Акции")
                            .customFont(weight: .medium, size: 20)
                            .foregroundStyle(Color.customBlack)
                        Spacer()
                        Text("Все")
                            .customFont(weight: .medium, size: 15)
                            .foregroundStyle(Color.customBlue)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RealHomeView()
        .environmentObject(HomeViewModel())
}
