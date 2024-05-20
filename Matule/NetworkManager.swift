//
//  NetworkManager.swift
//  Matule
//
//  Created by Вадим Мартыненко on 15.05.2024.
//

import Foundation
import Network

final class NetworkManager {
    static let instance = NetworkManager()
    
    @Published var isConnected: Bool = false
    
    private let manager = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.connect")
    
    init() {
        manager.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied
            
            DispatchQueue.main.async {
                self.isConnected = isConnected
            }
        }
        manager.start(queue: queue)
    }
}
