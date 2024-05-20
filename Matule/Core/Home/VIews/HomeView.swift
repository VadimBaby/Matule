//
//  HomeView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 11.05.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var active: Screens = .home
    
    enum Screens: CaseIterable {
        case home, like, bag, notification, profile
        
        var icon: String {
            switch self {
            case .home:
                "house"
            case .like:
                "heart"
            case .bag:
                "bag"
            case .notification:
                "bell"
            case .profile:
                "person"
            }
        }
    }
    
    var body: some View {
        VStack {
            
            VStack {
                switch active {
                case .home:
                    RealHomeView()
                case .like:
                    FavoriteView()
                case .bag:
                    Text("Bag")
                case .notification:
                    Text("not")
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            HStack {
                ForEach(Screens.allCases, id: \.self) { value in
                    if value == .bag {
                        Circle()
                            .fill(Color.customBlue)
                            .frame(width: 56, height: 56)
                            .overlay {
                                Image(systemName: value.icon)
                                    .font(.title2)
                                    .foregroundStyle(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(y: -35)
                            .shadow(color: Color.customBlue.opacity(0.5), radius: 15)
                    } else {
                        Image(systemName: value.icon)
                            .foregroundColor(active == value ? Color.customBlue : Color.customGray)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onTapGesture {
                                self.active = value
                            }
                    }
                }
            }
            .frame(width: nil, height: 96, alignment: .bottom)
            .padding(.bottom)
            .background {
                Image("bottom_bar")
                    .resizable()
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationBarBackButtonHidden()
        .background {
            Color.customLightGray
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    HomeView()
}
