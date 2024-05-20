//
//  ProfileView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 14.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    let brightness: CGFloat
    
    init() {
        self.brightness = UIScreen.main.brightness
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image("guy")
                .resizable()
                .frame(width: 96, height: 96)
                .clipShape(Circle())
            Text("Emmanuel Oyiboke")
                .foregroundStyle(Color.customBlack)
                .customFont(weight: .medium, size: 20)
            Text("Изменить фото профиля")
                .foregroundStyle(Color.customBlue)
                .customFont(weight: .regular, size: 12)
            Image("barcode")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 90)
        }
        .padding()
        .addHeader(title: "Профиль", rightIcon: nil, dismiss: nil)
        .onAppear {
            UIScreen.main.brightness = CGFloat(0.8)
        }
        .onDisappear {
            UIScreen.main.brightness = brightness
        }
    }
    
//    func generateBarcode(from string: String) -> UIImage? {
//        let data = string.data(using: String.Encoding.ascii)
//
//        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
//            filter.setValue(data, forKey: "inputMessage")
//            let transform = CGAffineTransform(scaleX: 3, y: 3)
//
//            if let output = filter.outputImage?.transformed(by: transform) {
//                return UIImage(ciImage: output)
//            }
//        }
//
//        return nil
//    }
}

#Preview {
    ProfileView()
}
