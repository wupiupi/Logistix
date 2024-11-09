//
//  Order.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import Foundation

enum OrderStatus: String {
    case onModeration = "На модерации"
    case searchingForDriver = "Ищем водителя"
    case inDelivery = "Передан в доставку"
    case cancelled = "Отменен"
    case finished = "Завершен"
    case inProcess = "В работе"
}

struct Order: Codable, Identifiable, Hashable {
    let id: String
    let userID: String
    var assignedDriverID: String?
    var status: String
    let sourceAddress: String
    let destinationAddress: String
    let senderName: String
    let senderPhoneNumber: String
    let recipientName: String
    let recipientPhoneNumber: String
    let cargoType: String
    let weight: String
    let dateOfLoading: Date
    let dateOfDelivery: Date
    let cargoCost: String
    let paymentType: String
    let totalCost: String
}
