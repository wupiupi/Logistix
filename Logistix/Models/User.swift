//
//  User.swift
//  Logistix
//
//  Created by Paul Makey on 7.11.24.
//

import Foundation

enum Role: String {
    case admin
    case driver
    case user
}

struct User: Codable, Identifiable {
    let id: String
    let auto: String
    let email: String
    let name: String
    let pass: String
    let role: String
    var orders: [Order]
    var applications: [Application]
}
