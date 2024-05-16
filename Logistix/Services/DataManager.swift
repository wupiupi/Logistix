//
//  DataManager.swift
//  Logistix
//
//  Created by Serge Broski on 5/15/24.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private let storageManager = StorageManager.shared
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        let firstOrder = Order_()
//        firstOrder.id = "123456"
        firstOrder.status = "Ожидает подтверждения"
        firstOrder.sourceAddress = "Притыцкого, 12"
        firstOrder.destinationAddress = "Независимости, 124"
        firstOrder.senderName = "Павел"
        firstOrder.senderPhoneNumber = "+375(25)444-44-55"
        firstOrder.recipientName = "Олег"
        firstOrder.recipientPhoneNumber = "+375(25)111-22-33"
        firstOrder.cargoType = "скоропортящихся продуктов"
        firstOrder.weight = "100кг"
        firstOrder.dateOfLoading = Date()
        firstOrder.dateOfDelivery = Date()
        firstOrder.cargoCost = "200"
        firstOrder.payment = "card"
        firstOrder.totalCost = "10000"

        let secondOrder = Order_()
//        secondOrder.id = "789212"
        secondOrder.status = "В пути"
        secondOrder.sourceAddress = "Пушкинская, 12"
        secondOrder.destinationAddress = "Независимости 124"
        secondOrder.senderName = "Геральд"
        secondOrder.senderPhoneNumber = "+375(25)476-53-22"
        secondOrder.recipientName = "Йениффер"
        secondOrder.recipientPhoneNumber = "+375(29)062-83-93"
        secondOrder.cargoType = "строительных материалов"
        secondOrder.weight = "100кг"
        secondOrder.dateOfLoading = Date()
        secondOrder.dateOfDelivery = Date()
        secondOrder.cargoCost = "200"
        secondOrder.payment = "card"
        secondOrder.totalCost = "10000"
        
        
        DispatchQueue.main.async { [unowned self] in
            storageManager.save([firstOrder, secondOrder])
            completion()
        }
    }
}
