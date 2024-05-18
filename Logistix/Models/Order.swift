//
//  Order.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import Foundation
import RealmSwift

final class Order: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var userID = ""
    @Persisted var trackingNumber = " "
    @Persisted var status = "ожидает подтверждения"
//    @Persisted var route: Route?
    @Persisted var sourceAddress = ""
    @Persisted var destinationAddress = ""
//    @Persisted var sender: Sender?
    @Persisted var senderName = ""
    @Persisted var senderPhoneNumber = ""
//    @Persisted var recipient: Recipient?
    @Persisted var recipientName = ""
    @Persisted var recipientPhoneNumber = ""
    @Persisted var cargoType = ""
    @Persisted var weight = ""
    @Persisted var dateOfLoading = Date()
    @Persisted var dateOfDelivery = Date()
//    @Persisted var price: Price?
    @Persisted var cargoCost = ""
    @Persisted var payment = ""
    @Persisted var totalCost = ""
}
