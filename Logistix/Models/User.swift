//
//  User.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation

enum Role: Codable {
    case user
    case admin
}

struct User: Codable {
    let id: String
    let role: Role
    let email: String
    let pass: String
    let orders: [Order]
}
