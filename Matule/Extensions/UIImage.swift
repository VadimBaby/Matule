//
//  UIImage.swift
//  Matule
//
//  Created by Вадим Мартыненко on 14.05.2024.
//

import Foundation
import SwiftUI

extension UIImage {
    convenience init?(barcode: String) {
            let data = barcode.data(using: .ascii)
            guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
                return nil
            }
            filter.setValue(data, forKey: "inputMessage")
            guard let ciImage = filter.outputImage else {
                return nil
            }
            self.init(ciImage: ciImage)
        }
}
