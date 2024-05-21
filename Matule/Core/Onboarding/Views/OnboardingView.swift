//
//  OnboardingView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import SwiftUI
import NavigationTransitions

struct OnboardingView: View {
    
    @StateObject private var viewModel: Self.ViewModel
    
    init(watchedQueueItemId: Int) {
        self._viewModel = StateObject(wrappedValue: .init(watchedQueueItemId: watchedQueueItemId))
    }
    
    enum OnboardingOptions: Int {
        case first = 1
        case second = 2
        case third = 3
    }
    
    var body: some View {
        Group {
            if let currentQueueItem = viewModel.currentQueueItem {
                ZStack(alignment: .bottom) {
                    Color.customBlue.ignoresSafeArea()
                    
                    if let value = OnboardingOptions(rawValue: currentQueueItem.id) {
                        switch value {
                        case .first:
                            WelconeOnboardingView()
                                .transition(.slide)
                        case .second:
                            OnboardingTitleView(id: 2, image: currentQueueItem.image.rawValue, title: currentQueueItem.title, subtitle: currentQueueItem.subtitle)
                                .transition(.slide)
                        case .third:
                            OnboardingTitleView(id: 3, image: currentQueueItem.image.rawValue, title: currentQueueItem.title, subtitle: currentQueueItem.subtitle)
                                .transition(.slide)
                        }
                    }
                    
                  //  OnboardingTitleView()
                    
                    if viewModel.showdNextButton {
                        Button("Next") {
                            viewModel.next()
                        }
                        .transition(.opacity)
                        .buttonStyle(WhiteButtonStyle())
                        .padding()
                    } else {
                        Button("Get started") {
                            viewModel.next()
                        }
                        .transition(.opacity)
                        .buttonStyle(WhiteButtonStyle())
                        .padding()
                    }
                }
            } else {
                NavigationStack {
                    SignInView()
                }
                .navigationTransition(.fade(.cross))
            }
        }
    }
}

#Preview {
    OnboardingView(watchedQueueItemId: 0)
}
