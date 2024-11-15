//
//  OrdersView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    private var userOrders: [Order] {
        filteredOrders.filter { $0.userID == authVM.currentUser?.id ?? ""}
    }
    
    private var filteredOrders: [Order] {
        if authVM.currentUser?.role == Role.admin.rawValue {
            guard !ordersVM.searchTerm.isEmpty else {
                return ordersVM.orders
            }
            return ordersVM.orders.filter { $0.id.localizedStandardContains(ordersVM.searchTerm) }
        } else {
            guard !ordersVM.searchTerm.isEmpty else {
                return authVM.currentUser?.orders ?? []
            }
            return authVM.currentUser?.orders.filter {
                $0.id.localizedCaseInsensitiveContains(ordersVM.searchTerm)
            } ?? []
        }
    }
    
    private var driverOrders: [Order] {
        ordersVM.orders.filter {
            ($0.status == OrderStatus.searchingForDriver.rawValue || $0.status == OrderStatus.inProcess.rawValue)
            && ($0.assignedDriverID == "" || $0.assignedDriverID == authVM.currentUser?.id)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    OrdersTitle()
                    
                    ForEach(
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
            case "user":
                return userOrders
            case "driver":
                return driverOrders
            default:
                return filteredOrders
        }
    }
}
