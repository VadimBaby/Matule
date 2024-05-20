//
//  MatuleApp.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import SwiftUI
import NavigationTransitions

@main
struct MatuleApp: App {
    
    let watchedQueueItemId: Int
    
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    
    init() {
        let watchedQueueItemId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.watchedQueueItemId)
        
        self.watchedQueueItemId = watchedQueueItemId
    }
    
    var body: some Scene {
        WindowGroup {
            if watchedQueueItemId != Constants.queue.last!.id {
                OnboardingView(watchedQueueItemId: watchedQueueItemId)
            } else {
                NavigationStack {
                   // SignInView()
                    HomeView()
                }
                .navigationTransition(.fade(.cross))
                .environmentObject(homeViewModel)
            }
        }
    }
}
