//
//  User.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation
import RealmSwift

enum Role: Codable {
    case user
    case admin
}

struct User: Codable {
    let id: String
    let role: Role
    let email: String
    let pass: String
    let orders: [Order_]
}

final class Order_: Object, Codable {
    @Persisted var sourceAddress = ""
    @Persisted var destinationAddress = ""
    @Persisted var senderName = ""
    @Persisted var senderPhoneNumber = ""
    @Persisted var recipientName = ""
    @Persisted var recipientPhoneNumber = ""
    @Persisted var cargoType = ""
    @Persisted var weight = ""
    @Persisted var dateOfLoading = ""
    @Persisted var dateOfDelivery = Date()
    @Persisted var cargoCost = ""
    @Persisted var payment = ""
    @Persisted var totalCost = ""
}
