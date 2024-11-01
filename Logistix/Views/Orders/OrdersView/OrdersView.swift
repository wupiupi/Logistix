//
//  OrdersView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI
import RealmSwift

struct OrdersView: View {
    @ObservedResults(Order.self) private var orders
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    private var userOrders: [Order] {
        filteredOrders.filter { $0.userID == authVM.currentUser?.id ?? ""}
    }
    
    private var filteredOrders: [Order] {
        guard !ordersVM.searchTerm.isEmpty else { return Array(orders) }
        return orders.filter { $0.trackingNumber.localizedCaseInsensitiveContains(ordersVM.searchTerm) }
    }
    
    private var driverOrders: [Order] {
        return filteredOrders.filter { $0.status == "Подтвержден" || $0.status == "В работе" }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    OrdersTitle()
                    
                    ForEach(
//                        authVM.currentUser?.role == Role.user.rawValue
//                        ? userOrders
//                        : filteredOrders,
                        getCorrectOrders(),
                        id: \.self
                    ) { order in
                        
                        Divider()
                        
                        // Order ID & Date of Loading
                        OrderIdView(order: order)
                        
                        // Expands the details of the order
                        ExpandableOrderView(order: order)
                    }
                }
                .padding()
            }
            .navigationTitle("Logistix")
            .toolbarBackground(
                LinearGradient(
                    colors: [
                        Color(hex: 0x00CCA6, alpha: 1),
                        Color(hex: 0x29B197, alpha: 0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                for: .navigationBar
            )
        }
        .searchable(
            text: $ordersVM.searchTerm,
            prompt: "Поиск по документам или заказам"
        )
    }
    
    private func getCorrectOrders() -> [Order] {
        switch authVM.currentUser?.role {
        case Role.user.rawValue:
            return userOrders
        case Role.driver.rawValue:
            return driverOrders
        default:
            return filteredOrders
        }
    }
}
