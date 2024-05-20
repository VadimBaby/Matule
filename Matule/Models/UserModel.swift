//
//  UserModel.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import Foundation

struct UserModel: Codable, Identifiable {
    let id: UUID
    let name: String
    let email: String
    let created_at: Date
}
