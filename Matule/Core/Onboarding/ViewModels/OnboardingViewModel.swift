//
//  OnboardingViewModel.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import Foundation
import Combine
import SwiftUI

extension OnboardingView {
    final class ViewModel: ObservableObject {
        // очередь
        @Published var queue: [QueueModel] = []
        
        // элемент очереди, который показывается на экране
        @Published var currentQueueItem: QueueModel? = nil
        
        // отвечает за отображение кнопок, если false то отображаются кнопка Next, если false то отображаются кнопка Get Started
        @Published private(set) var showdNextButton: Bool = false
        
        // содержит полную очередь
        private let fullQueue: [QueueModel] = Constants.queue
        
        private var queueCancellable: AnyCancellable? = nil
        
        init(watchedQueueItemId: Int, customQueue: [QueueModel]? = nil) {
            addSubcriber()
            
            self.queue = self.createQueue(watchedQueueItemId: watchedQueueItemId, fullQueue: customQueue ?? fullQueue)
            
            next()
        }
        
        // функция next, берет следующий элемент из очереди
        func next() {
            if self.queue.isEmpty {
                self.currentQueueItem = nil
                return
            }
            
            let element = self.queue.removeFirst()
            
            withAnimation(.linear) {
                self.currentQueueItem = element
            }
            
            save(id: element.id)
        }
        
        // функция skip, currentQueueItem приравняет к nil, очищает очередь
        func skip() {
            if let last = self.queue.last {
                save(id: last.id)
                self.queue = []
               
                withAnimation(.linear) {
                    self.currentQueueItem = nil
                }
            }
        }
        
        // сохраняет id в UserDefaults
        private func save(id: Int) {
            UserDefaults.standard.setValue(id, forKey: UserDefaultsKeys.watchedQueueItemId)
        }
        
        // создает очередь
        private func createQueue(watchedQueueItemId: Int, fullQueue: [QueueModel]) -> [QueueModel] {
            guard !watchedQueueItemId.isMultiple(of: 0) else { return fullQueue }
            
            var was = false
            
            let queue = fullQueue.reduce(Array<QueueModel>()) { result, item in
                var resultQueue = result
                
                if was {
                    resultQueue.append(item)
                } else {
                    was = item.id == watchedQueueItemId
                    
                    if was {
                        resultQueue.append(item)
                    }
                }
                
                return resultQueue
            }
            
            return queue
        }
        
        private func addSubcriber() {
            queueCancellable = $queue
                .sink { [weak self] queue in
                    guard let safeSelf = self else { return }
                    
                    if let currentQueueItem = safeSelf.currentQueueItem, currentQueueItem.id != 1 {
                        safeSelf.showdNextButton = true
                        safeSelf.queueCancellable?.cancel()
                    } else {
                        safeSelf.showdNextButton = false
                    }
                }
        }
    }
}
