//
//  SliderView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 21.05.2024.
//

import SwiftUI

struct SliderView: View {
    @State private var currentView: Views = .first
    
    @State private var slideX: CGFloat = .zero
    
    enum Views: CaseIterable {
        case first, second, third
    }
    
    var body: some View {
        ZStack {
            Color.customBlue.ignoresSafeArea()
            
            VStack {
                switch currentView {
                case .first:
                    makeView(icon: "house.fill", title: "First View", color: .customBlue)
                case .second:
                    makeView(icon: "gear", title: "Second View", color: .customBlue)
                case .third:
                    makeView(icon: "airpods", title: "Third View", color: .customBlue)
                }
                
                Button(action: {
                    withAnimation(.default) {
                        currentView = currentView.next()
                    }
                }, label: {
                    Text("Slide")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundStyle(Color.white)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 15))
                })
                .padding()
            }
        }
    }
}

extension SliderView {
    @ViewBuilder func makeView(icon: String, title: String, color: Color) -> some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            
            Text(title)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(color)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        .offset(x: slideX)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    withAnimation(.linear) {
                        slideX = value.translation.width
                    }
                })
                .onEnded({ value in
                    withAnimation(.linear(duration: 0.3)) {
                        slideX = -UIScreen.main.bounds.width
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        slideX = UIScreen.main.bounds.width / 2
                        currentView = currentView.next()
                        
                        withAnimation(.linear(duration: 0.2)) {
                            slideX = 0
                        }
                    }
                    
                })
        )
    }
}

#Preview {
    SliderView()
}

extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        // .endIndex содержит значение последнего индекса + 1
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
