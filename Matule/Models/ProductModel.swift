//
//  ProductModel.swift
//  Matule
//
//  Created by Вадим Мартыненко on 13.05.2024.
//

import Foundation


struct ProductModel: Identifiable, Codable {
    let id: String
    let name: String
    let img: String
    let isHeart: Bool
    let price: Int
}
