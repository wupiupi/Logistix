//
//  Order.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import Foundation

struct Order {
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
    let payment: String
    let totalCost: String
    
    static func MOCK_ORDER() -> Order {
        Order(
            sourceAddress: "Притыцкого 12",
            destinationAddress: "Независимости 124",
            senderName: "Павел",
            senderPhoneNumber: "+375(25)444-44-55",
            recipientName: "Олег",
            recipientPhoneNumber: "+375(25)111-22-33",
            cargoType: "Скоропортящиеся продукты",
            weight: "100кг",
            dateOfLoading: Date(),
            dateOfDelivery: Date(),
            cargoCost: "200",
            payment: "card",
            totalCost: "10000"
        )
    }
}
