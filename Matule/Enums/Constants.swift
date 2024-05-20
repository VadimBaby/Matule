//
//  Constants.swift
//  Matule
//
//  Created by Вадим Мартыненко on 09.05.2024.
//

import Foundation

enum Constants {
    static let queue: [QueueModel] = [
        .init(id: 1, image: .legSneaker, title: "Welcome to Nike", subtitle: ""),
        .init(id: 2, image: .secondSneaker, title: "Let’s Start Journey\nWith Nike", subtitle: "Smart, Gorgeous & Fashionable\nCollection Explor Now"),
        .init(id: 3, image: .jordanSneaker, title: "You Have the\nPower To", subtitle: "There Are Many Beautiful And Attractive\nPlants To Your Room")
    ]
    
    static let products: [ProductModel] = [
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799),
        ProductModel(id: UUID().uuidString, name: "Nike Air Max", img: "sneaker", isHeart: false, price: 799)
    ]
}
