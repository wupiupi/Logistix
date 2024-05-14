//
//  OrdersViewModel.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import Foundation

final class OrdersViewModel: ObservableObject {
    @Published var orders: [Order]
    
    init() {
        orders = Order.MOCK_ORDERS()
    }
}
