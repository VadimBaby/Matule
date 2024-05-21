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
            
            Test()
//            if watchedQueueItemId != Constants.queue.last!.id {
//                OnboardingView(watchedQueueItemId: watchedQueueItemId)
//            } else {
//                NavigationStack {
//                   // SignInView()
//                    HomeView()
//                }
//                .navigationTransition(.fade(.cross))
//                .environmentObject(homeViewModel)
//            }
        }
    }
}

struct Test: View {
    
    @State var image: UIImage? = nil
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            Button("Show") {
                show.toggle()
            }
        }
        .sheet(isPresented: $show, content: {
            ImagePickerView(image: $image, showScreen: $show)
        })
    }
}
