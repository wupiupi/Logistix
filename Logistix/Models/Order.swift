//
//  Order.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import Foundation

struct Order: Hashable {
    let id: String
    let trackingNumber = String.generateTrackNum()
    let status: String
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
    
    static func MOCK_ORDERS() -> [Order] {
        [
            Order(
                id: "123456",
                status: "Ожидает подтверждения",
                sourceAddress: "Притыцкого, 12",
                destinationAddress: "Независимости, 124",
                senderName: "Павел",
                senderPhoneNumber: "+375(25)444-44-55",
                recipientName: "Олег",
                recipientPhoneNumber: "+375(25)111-22-33",
                cargoType: "скоропортящихся продуктов",
                weight: "100кг",
                dateOfLoading: Date(),
                dateOfDelivery: Date(),
                cargoCost: "200",
                payment: "card",
                totalCost: "10000"
            ),
            Order(
                id: "789212",
                status: "В пути",
                sourceAddress: "Пушкинская, 12",
                destinationAddress: "Независимости 124",
                senderName: "Геральд",
                senderPhoneNumber: "+375(25)476-53-22",
                recipientName: "Йениффер",
                recipientPhoneNumber: "+375(29)062-83-93",
                cargoType: "строительных материалов",
                weight: "100кг",
                dateOfLoading: Date(),
                dateOfDelivery: Date(),
                cargoCost: "200",
                payment: "card",
                totalCost: "10000"
            )
        ]
    }
}
