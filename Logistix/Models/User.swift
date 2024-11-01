//
//  User.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation

enum Role: String {
    case user
    case admin
    case driver
}

struct User: Codable, Identifiable {
    let id: String
    let role: String
    let email: String
    let name: String
    let pass: String
    let auto: String?
}
