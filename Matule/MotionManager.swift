//
//  MotionManager.swift
//  Matule
//
//  Created by Вадим Мартыненко on 15.05.2024.
//

import Foundation
import CoreMotion

final class MotionManager {
    static let instance = MotionManager()
    
    @Published var angle: Double = .zero
    
    private let motionManager = CMMotionManager()
    
    init() {
        motionManager.deviceMotionUpdateInterval = 0.5
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion else { return }
            
            let roll = motion.attitude.roll
            let angle: Double = roll / 180 * .pi
            
            DispatchQueue.main.async {
                self.angle = angle
            }
        }
    }
}
