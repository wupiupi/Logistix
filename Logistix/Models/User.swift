//
//  User.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation
import RealmSwift

final class User: Object {
    @Persisted var email = ""
    @Persisted var pass = ""
    @Persisted var orders = List<Order_>()
}

final class Order_: Object {
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
